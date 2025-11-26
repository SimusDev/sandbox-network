extends Node
class_name S_PlayerAuth

static var _instance: S_PlayerAuth

func _ready() -> void:
	_instance = self
	SD_Network.register_functions([
		
	])

static func request_login() -> void:
	pass
