extends Node
class_name S_GameSingletonBase

func _ready() -> void:
	SD_Network.register_object(self, false)
	_initialized()

func _initialized() -> void:
	pass
