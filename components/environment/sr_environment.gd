extends Node3D
class_name SR_Environment

func _ready() -> void:
	SD_Network.register_channel("environment")
	SD_Network.register_object(self)
	SD_Network.register_function(_test)

func _test() -> void:
	pass

func _on_timer_timeout() -> void:
	if SD_Network.is_server():
		SD_Network.call_func_except_self(_test, [], SD_Network.CALLMODE.UNRELIABLE, "environment")
