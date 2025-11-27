extends Node3D
class_name SR_SoundSource3D

var object: R_Sound3D

var _streams_count: int = 0
var _streams_finished: int = 0

func _ready() -> void:
	if !object:
		object = I_ObjectInstance.find_in(self).object
	
	if not object:
		SD_Console.i().write_from_object(self, "cant find R_Sound3D object!", SD_ConsoleCategories.ERROR)
		queue_free()
		return
	
	
	
	for pack in object.pack:
		var player: AudioStreamPlayer3D = pack.try_create(global_position)
		if player:
			_streams_count += 1
			player.finished.connect(_on_stream_finished)
			add_child.call_deferred(player)

func _on_stream_finished() -> void:
	_streams_finished += 1
	if _streams_finished >= _streams_count:
		queue_free()
