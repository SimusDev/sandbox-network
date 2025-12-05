extends R_Object
class_name R_PlayerSpawn3D

@export var level: R_Level3D

@export var position: Vector3 = Vector3.ZERO
@export var rotation: Vector3 = Vector3.ZERO

static var list: Array[R_PlayerSpawn3D] = []

var __instance: SR_Level3D

func get_default_tab() -> R_Tab:
	if level:
		return R_Tab.create_global("player_spawn." + level.name)
	return R_Tab.create_global("player_spawn")

func register() -> void:
	super()
	
	if not level:
		SD_Console.i().write_error("(%s): cant find level resource!" % [id])
		return
	

func _registered() -> void:
	list.append(self)

func _unregistered() -> void:
	list.erase(self)
