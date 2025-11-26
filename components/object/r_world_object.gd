extends R_Object
class_name R_WorldObject

@export var prefab: PackedScene : get = get_prefab

func get_prefab() -> PackedScene:
	return prefab

func register() -> void:
	super()
	SD_Network.singleton.cache.cache_resource(prefab)
