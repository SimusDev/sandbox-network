extends Resource
class_name R_Level3D

@export var size: Vector3 = Vector3.ZERO
@export var position: Vector3 = Vector3.ZERO
@export var lobby: bool = false
@export var visible: bool = true
@export var name: StringName = ""
@export var map_prefabs: Array[PackedScene] = []
@export var prefabs: Array[PackedScene] = []
@export var online_prefabs: Array[PackedScene] = []
@export var offline_prefabs: Array[PackedScene] = []
@export var server_prefabs: Array[PackedScene] = []

const LEVEL_BASE: PackedScene = preload("uid://cerh8ahldbw0c") as PackedScene

var __instance: SR_Level3D

func init() -> void:
	if name.is_empty():
		name = resource_path.get_file().get_basename()

func get_local_instance() -> SR_Level3D:
	return __instance

func create_instance() -> SR_Level3D:
	init()
	var instance: SR_Level3D = LEVEL_BASE.instantiate() as SR_Level3D
	instance._resource = self
	instance.name = name.validate_node_name()
	
	instance.position = position * size
	
	__instance = instance
	return instance
