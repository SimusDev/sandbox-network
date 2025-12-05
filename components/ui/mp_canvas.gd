class_name MP_Interface extends CanvasLayer

@export var scene:PackedScene

static var instance:MP_Interface = null

static func get_instance() -> MP_Interface:
	return instance

func _ready() -> void:
	if not SD_Network.is_authority(self):
		queue_free()
		return
	
	instance = self
	add_child(scene.instantiate())
