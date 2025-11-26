extends Node3D
class_name SR_SoundSource3D

@export var object: R_Sound3D

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
			add_child.call_deferred(player)
	
