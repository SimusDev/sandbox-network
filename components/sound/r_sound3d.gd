extends R_WorldObject
class_name R_Sound3D

@export var global: bool = false
@export var pack: Array[R_SoundPack3D] = []

func get_default_tab() -> R_Tab:
	return R_Tab.create_global("sound")

func _registered() -> void:
	prefab = load("uid://dxnpl1v1ilrod")

func try_create_source(position: Variant) -> SR_SoundSource3D:
	var camera: Camera3D = SR_GameWorld3D.try_get_active_camera3d()
	position = SR_GameWorld3D.get_position_or_node3d_position_globally(position)
	
	var max_distance: float = 0.0
	for p in pack:
		if p.max_distance > max_distance:
			max_distance = p.max_distance
	
	if max_distance > 0:
		if camera.global_position.distance_to(position) >= max_distance:
			return null
	
	var sound := SR_SoundSource3D.new()
	sound.object = self
	return sound

func play_locally(position: Variant) -> SR_SoundSource3D:
	var sound: SR_SoundSource3D = try_create_source(position)
	if sound:
		SR_GameWorld3D.instance.add_child.call_deferred(sound)
	return sound
