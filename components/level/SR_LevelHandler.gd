extends Node3D
class_name SR_LevelHandler

@export_dir var levels_path: String

@export var _lobby: R_Level3D

var _lobby_level: SR_Level3D

func _ready() -> void:
	_lobby_level = _create_level(_lobby)
	
	if SD_Network.is_server():
		for path in SD_FileSystem.get_all_files_with_extension_from_directory(levels_path, SD_FileExtensions.EC_RESOURCE):
			var resource: Resource = load(path)
			if resource is R_Level3D:
				if resource == _lobby:
					continue
				
				_create_level(resource)

func _create_level(resource: R_Level3D) -> SR_Level3D:
	var instance: SR_Level3D = resource.create_instance()
	add_child(instance)
	return instance
