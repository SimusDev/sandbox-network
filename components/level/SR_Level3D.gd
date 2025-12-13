extends Node3D
class_name SR_Level3D

@export var _resource: R_Level3D

@export var _spawner: SD_NetworkSpawner

var _sections: Dictionary[String, SR_LevelSection3D] = {}

@onready var status: SR_OnlineOfflineObject = SR_OnlineOfflineObject.get_or_create(self).set_static(true).set_offline()

var _players: Array[SR_Playable] = []

func get_spawner() -> SD_NetworkSpawner:
	return _spawner

func _ready() -> void:
	if not _resource:
		return
	
	SD_Console.i().write_warning("level loading... %s" % [_resource])
	
	status.status_changed.connect(_on_status_changed)
	
	_instantiate_prefabs($Prefabs, _resource.prefabs)
	
	if SD_Network.is_server():
		_instantiate_prefabs($Prefabs/Server, _resource.server_prefabs)
	
	_initialize_level_sections()
	
	_on_status_changed()

func _initialize_level_sections() -> void:
	if not _resource.visible:
		return
	
	
	for tab_name in R_Tab.get_globals():
		var _tab: R_Tab = R_Tab.get_globals()[tab_name]
		var section: SR_LevelSection3D = SR_LevelSection3D.new()
		section.name = tab_name
		add_child(section)
		
		var section_local: SR_LevelSection3D = SR_LevelSection3D.new()
		section_local.networked = false
		section_local.name = "l_" + tab_name
		add_child(section_local)

func _instantiate_prefabs(parent: Node, prefabs: Array[PackedScene]) -> void:
	await get_tree().process_frame
	for p in prefabs:
		if p:
			var instance: Node = p.instantiate()
			instance.name = str(parent.get_child_count())
			parent.add_child(instance)

func _clear_children(parent: Node) -> void:
	for i in parent.get_children():
		i.queue_free()

static func find_level(from: Node) -> SR_Level3D:
	if from is SR_Level3D:
		return from
	return find_level(from.get_parent())

func find_section(section_name: String) -> SR_LevelSection3D:
	return _sections.get(section_name)

func find_section_by_object(object: R_WorldObject) -> SR_LevelSection3D:
	return find_section(object.tab.id)

func _create_instance(object: R_WorldObject, local: bool = false) -> I_ObjectInstance:
	if not SD_Network.is_server() and local == false:
		SD_Console.i().write_from_object(self, "cant instantiate globally on client! %s" % [object.resource_path], SD_ConsoleCategories.ERROR)
		return
	
	var instance: I_ObjectInstance = I_ObjectInstance.new()
	
	if !is_instance_valid(object):
		SD_Console.i().write_from_object(self, "cant instantiate, object is null!", SD_ConsoleCategories.ERROR)
		return instance
	
	if !object.prefab:
		SD_Console.i().write_from_object(self, "cant instantiate, object(%s) prefab is null!" % [str(object.resource_path)], SD_ConsoleCategories.ERROR)
		return instance
	
	var node: Node = object.get_prefab().instantiate()
	instance.object = object
	instance.set_in(node)
	
	var parent: Node = null
	
	if local:
		parent = find_section_by_object(object).get_local()
	else:
		parent = find_section_by_object(object)
	
	instance.parent = parent
	
	return instance
	

func instantiate(object: R_WorldObject) -> I_ObjectInstance:
	return _create_instance(object, false)

func instantiate_local(object: R_WorldObject) -> I_ObjectInstance:
	return _create_instance(object, true)

func _player_entered(player: SR_Playable) -> void:
	_players.append(player)
	_try_update_online_offline_status()
	
	if SD_Network.is_server():
		SR_LevelHandler._server_send_level_to_peer(player.network.get_peer_id(), _resource)

func _player_exited(player: SR_Playable) -> void:
	_players.erase(player)
	_try_update_online_offline_status()

func _try_update_online_offline_status() -> void:
	status.set_offline(_players.is_empty())

func _on_status_changed() -> void:
	if status.is_online():
		_instantiate_prefabs($Prefabs/Maps, _resource.map_prefabs)
		_instantiate_prefabs($Prefabs/Online, _resource.online_prefabs)
		_clear_children($Prefabs/Offline)
	else:
		_clear_children($Prefabs/Maps)
		_instantiate_prefabs($Prefabs/Offline, _resource.offline_prefabs)
		_clear_children($Prefabs/Online)
		

func teleport(node: Node) -> I_ObjectInstance:
	if SD_Network.is_server():
		var object: I_ObjectInstance = I_ObjectInstance.find_in(node)
		if !object:
			SD_Console.i().write_from_object(self, "cant teleport '%s', object instance not found!", SD_ConsoleCategories.ERROR)
			return null
		
		var node_level: SR_Level3D = object.find_level()
		if node_level == self:
			return object
		
		var section: SR_LevelSection3D = find_section_by_object(object.object)
		
		object.reparent(section)
		
		return object
	return null
