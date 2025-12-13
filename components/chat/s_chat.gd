extends S_GameSingletonBase
class_name S_Chat

static var _instance: S_Chat

static var _network: SD_NetworkFunctionCaller = SD_NetworkFunctionCaller.new("chat")

signal on_message_recieved(msg: String)

static func get_instance() -> S_Chat:
	return _instance

func _initialized() -> void:
	_instance = self
	
	SD_Network.register_functions([
		_send_message_server,
	])

static func send_message(msg: String) -> void:
	_network.call_func_on_server(_instance._send_message_server, [msg])

func _send_message_server(msg: String) -> void:
	if not SD_Network.is_server():
		return
	
	var sender: SD_NetSender = SD_Network.remote_sender
	
	var user: R_UserData = SR_ServerAuthData.find_by_peer_id(sender.id)
	if user:
		msg = user.name + ": " + msg
	
	_network.call_func(_recieve_message_from_server, [msg])

func _recieve_message_from_server(msg: String) -> void:
	on_message_recieved.emit(msg)

static func server_send_message(msg: String) -> void:
	send_message("[SERVER] %s" % [msg])
