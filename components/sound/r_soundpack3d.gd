extends Resource
class_name R_SoundPack3D

@export var streams: Array[AudioStream]
@export var bus: StringName = "game"
@export var unit_size: float = 10.0
@export var max_db: float = 3.0
@export var pitch_min: float = 1.0
@export var pitch_max: float = 1.0
@export var min_distance: float = 0.0
@export var max_distance: float = 0.0

func try_create(global_position: Vector3) -> AudioStreamPlayer3D:
	var camera: Camera3D = SR_GameWorld3D.try_get_active_camera3d()
	if !is_instance_valid(camera):
		return null
	
	if min_distance > 0:
		if camera.global_position.distance_to(global_position) <= min_distance:
			return
	
	if max_distance > 0:
		if camera.global_position.distance_to(global_position) >= max_distance:
			return
	
	var audio := AudioStreamPlayer3D.new()
	audio.bus = bus
	audio.unit_size = unit_size
	audio.max_db = max_db
	audio.max_distance = max_distance
	audio.pitch_scale = SD_Random.get_rfloat_range(pitch_min, pitch_max)
	
	return audio
