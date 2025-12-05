extends Node3D
class_name SR_Environment

static var _instance: SR_Environment

@onready var _sky_3d: Sky3D = $Sky3D

func _enter_tree() -> void:
	_instance = self

func _ready() -> void:
	SD_Network.register_channel("environment")
	SD_Network.register_object(self)

static func time_set(time: float) -> void:
	_instance._sky_3d.current_time = time

func _on_sd_node_console_commands_on_executed(command: SD_ConsoleCommand) -> void:
	match command.get_code():
		"env.time_set":
			time_set(command.get_value_as_float())
