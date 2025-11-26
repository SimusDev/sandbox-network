extends Node
class_name SR_ObjectHandler

@export var paths: Array[String] = []
@export var unload_on_free: bool = true

var _resources: Array[R_Object] = []

func _ready() -> void:
	for path in paths:
		for file in SD_FileSystem.get_all_files_with_extension_from_directory(path, SD_FileExtensions.EC_RESOURCE):
			var resource: Resource = load(file)
			print(resource)
			if resource is R_Object:
				_resources.append(resource)
				resource.register()

func _exit_tree() -> void:
	if unload_on_free:
		for resource in _resources:
			resource.unregister()
