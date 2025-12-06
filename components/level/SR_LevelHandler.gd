extends Node3D
class_name SR_LevelHandler

@export_dir var levels_path: String

@export var _lobby: R_Level3D

var _lobby_level: SR_Level3D

static var __instance: SR_LevelHandler

static var network: SD_NetworkFunctionCaller = SD_NetworkFunctionCaller.new("level")

func _ready() -> void:
	__instance = self
	
	SD_Network.register_object(self, false)
	
	#_lobby_level = _create_level(_lobby)
	
	if SD_Network.is_server():
		for path in SD_FileSystem.get_all_files_with_extension_from_directory(levels_path, SD_FileExtensions.EC_RESOURCE):
			var resource: Resource = load(path)
			if resource is R_Level3D:
				if !resource.visible:
					continue
				
				SD_Network.singleton.cache.cache_resource(resource)
				
				_create_level(resource)

func _create_level(resource: R_Level3D) -> SR_Level3D:
	var instance: SR_Level3D = resource.create_instance()
	add_child(instance)
	return instance

func _change_level(resource: R_Level3D) -> void:
	for i in get_children():
		i.queue_free()
		await i.tree_exited
	
	return _create_level(resource)

static func _server_send_level_to_peer(peer: int, level: R_Level3D) -> void:
	if not SD_Network.is_server():
		return
	
	network.call_func_on(peer, __instance._recieve_level_from_server, [level])

func _recieve_level_from_server(level: R_Level3D) -> void:
	if SD_Network.is_server():
		return
	
	_change_level(level)
