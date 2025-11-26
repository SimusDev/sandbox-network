extends Node3D
class_name SR_SoundSource3D

@export var object: R_Sound3D

func _ready() -> void:
	if !object:
		object = I_ObjectInstance.find_in(self).object
	
