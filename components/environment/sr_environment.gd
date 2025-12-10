extends Node3D
class_name SR_Environment

static var _instance: SR_Environment

@onready var _sky_3d: Sky3D = $Sky3D
@onready var _time_of_day: TimeOfDay = $Sky3D/TimeOfDay

func _enter_tree() -> void:
	_instance = self

func _ready() -> void:
	SD_Network.register_object(self, false)
	
	SD_NetworkReplicator.attach_or_get(_sky_3d).set_vars_tickrate(1).set_vars_channel("environment").register_vars(
		[
			"current_time",
			"minutes_per_day",
		]
	)
	
	SD_NetworkReplicator.attach_or_get(_time_of_day).set_vars_tickrate(1).set_vars_channel("environment").register_vars(
	[
		"day",
		"month",
		"year",
	]
)

static func time_set(time: float) -> void:
	_instance._sky_3d.current_time = time

func _on_sd_node_console_commands_on_executed(command: SD_ConsoleCommand) -> void:
	match command.get_code():
		"env.time_set":
			time_set(command.get_value_as_float())

func _on_timer_timeout() -> void:
	if SD_Network.is_server():
		SD_Network.call_func_except_self(_recieve)
		

func _recieve() -> void:
	return
	print("method called from server!")
