extends R_WorldObject
class_name R_Sound3D

@export var pack: Array = []

func get_default_tab() -> R_Tab:
	return R_Tab.create_global("sound")

func _registered() -> void:
	prefab = load("uid://dxnpl1v1ilrod")
	
