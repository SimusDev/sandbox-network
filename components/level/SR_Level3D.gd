extends Node3D
class_name SR_Level3D

@export var _resource: R_Level3D

@export var _spawner: SD_NetworkSpawner

var _sections: Dictionary[String, SR_LevelSection3D] = {}

func get_spawner() -> SD_NetworkSpawner:
	return _spawner

func _ready() -> void:
	if not _resource:
		return
	
	SD_Console.i().write_warning("level loading... %s" % [_resource])
	
	_instantiate_prefabs($Prefabs, _resource.prefabs)
	
	_initialize_level_sections()

func _initialize_level_sections() -> void:
	for tab_name in R_Tab.get_globals():
		var tab: R_Tab = R_Tab.get_globals()[tab_name]
		var section: SR_LevelSection3D = SR_LevelSection3D.new()
		section.name = tab_name
		add_child(section)
		
		var section_local: SR_LevelSection3D = SR_LevelSection3D.new()
		section_local.networked = false
		section_local.name = "l_" + tab_name
		add_child(section_local)

func _instantiate_prefabs(parent: Node, prefabs: Array[PackedScene]) -> void:
	for p in prefabs:
		if p:
			var instance: Node = p.instantiate()
			instance.name = str(parent.get_child_count())
			parent.add_child(instance)

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
