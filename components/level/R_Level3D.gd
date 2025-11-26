extends Resource
class_name R_Level3D

@export var visible: bool = true
@export var name: StringName = "level3d"
@export var prefabs: Array[PackedScene] = []
@export var online_prefabs: Array[PackedScene] = []
@export var offline_prefabs: Array[PackedScene] = []
@export var server_prefabs: Array[PackedScene] = []

const LEVEL_BASE: PackedScene = preload("uid://cerh8ahldbw0c") as PackedScene

func create_instance() -> SR_Level3D:
	var instance: SR_Level3D = LEVEL_BASE.instantiate() as SR_Level3D
	instance._resource = self
	instance.name = name.validate_node_name()
	return instance

func spawn(object: R_WorldObject) -> I_ObjectInstance:
	if SD_Network.is_server():
		return null
	
	var instance: I_ObjectInstance
	
	return instance
