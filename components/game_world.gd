extends Node3D
class_name SR_GameWorld3D

static var instance: SR_GameWorld3D

func _enter_tree() -> void:
	instance = self

static func get_position_or_node3d_position_globally(from: Variant) -> Vector3:
	if is_instance_valid(from): 
		if "global_position" in from:
			return from.global_position
	
	elif from is Vector3:
		return from
	return Vector3()

static func try_get_active_camera3d() -> Camera3D:
	return SimusDev.get_tree().root.get_camera_3d()
