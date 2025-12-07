extends S_GameSingletonBase
class_name S_PlayerCharacterSelect

var network: SD_NetworkFunctionCaller = SD_NetworkFunctionCaller.new("auth")

static var _instance: S_PlayerCharacterSelect

@export var _player_object: R_Player

signal on_success()

func _initialized() -> void:
	_instance = self
	
	SD_Network.register_functions([
		_play_server
	])

static func register_success_callback(method: Callable) -> void:
	_instance.on_success.connect(method)

static func play(selection: R_UserCharacterSelect) -> void:
	if not S_PlayerAuth.is_logged_and_active():
		SD_Console.i().write_error("you must login first!")
		return
	
	_instance.network.call_func_on_server(_instance._play_server, [selection.serialize()])

func _play_server(serialized: Variant) -> void:
	if not SD_Network.is_server():
		return
	
	var selection: R_UserCharacterSelect = R_UserCharacterSelect.deserialize(serialized)
	
	var spawn: R_PlayerSpawn3D = selection.spawn
	
	var p_instance: I_ObjectInstance = spawn.level.get_local_instance().instantiate(_player_object)
	var network_player: SD_NetworkPlayer = SD_NetworkPlayer.get_by_peer_id(SD_Network.get_remote_sender_id())
	network_player.set_in(p_instance.owner)
	
	p_instance.spawn()
	p_instance.set_global_position(spawn.position)
	p_instance.set_global_rotation(spawn.rotation)
	
	network.call_func_on(SD_Network.get_remote_sender_id(), _recieve_success)


func _recieve_success() -> void:
	on_success.emit()
