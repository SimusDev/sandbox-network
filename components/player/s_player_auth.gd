extends S_GameSingletonBase
class_name S_PlayerAuth

static var _instance: S_PlayerAuth

enum ERROR
{
	PASSWORD_EMPTY,
	INCORRECT_PASSWORD,
}

@onready var cmd_login: SD_ConsoleCommand = SD_ConsoleCommand.get_or_create("login", "user")
@onready var cmd_password: SD_ConsoleCommand = SD_ConsoleCommand.get_or_create("password")

@onready var data: SR_ServerAuthData = SR_ServerAuthData.get_or_create(SR_ServerAuthData)

var network: SD_NetworkFunctionCaller = SD_NetworkFunctionCaller.new("auth")

signal on_error(error: ERROR)
signal on_success()

var _logged_and_active: bool = false

static func is_logged_and_active() -> bool:
	return _instance._logged_and_active

static func get_last_login() -> String:
	return _instance.cmd_login.get_value_as_string()

static func get_last_password() -> String:
	return _instance.cmd_password.get_value_as_string()

func _initialized() -> void:
	data.instance = data
	_instance = self
	
	if SD_Network.is_server():
		SD_Network.singleton.on_player_disconnected.connect(_on_player_disconnected)
	
	SD_Network.register_functions([
		_request_login_rpc,
	])

func _on_player_disconnected(player: SD_NetworkPlayer) -> void:
	pass

static func request_login(login: String, password: String) -> void:
	_instance.cmd_login.set_value(login)
	_instance.cmd_password.set_value(password)
	
	_instance.network.call_func_on_server(_instance._request_login_rpc, [login, password])

func _request_login_rpc(login: String, password: String) -> void:
	if not SD_Network.is_server():
		return
	
	var sender: int = SD_Network.get_remote_sender_id()
	
	if password.is_empty():
		_server_throw_error_to(sender, ERROR.PASSWORD_EMPTY)
		return
	
	var user: R_UserData = data.find_by_name(login)
	if user:
		if user.password == password:
			user.peer = sender
			_server_throw_success_to(sender)
		else:
			_server_throw_error_to(sender, ERROR.INCORRECT_PASSWORD)
		return
	
	var new_user: R_UserData = R_UserData.new()
	new_user.peer = sender
	new_user.name = login
	new_user.password = password
	data.users.append(new_user)
	data.save()

static func _server_throw_error_to(peer: int, error: ERROR) -> void:
	if SD_Network.is_server():
		_instance.network.call_func_on(peer, _instance._recieve_error, [error])

static func _server_throw_success_to(peer: int) -> void:
	if SD_Network.is_server():
		_instance.network.call_func_on(peer, _instance._recieve_success)


func _recieve_error(error: ERROR) -> void:
	on_error.emit(error)

func _recieve_success() -> void:
	_instance._logged_and_active = true
	on_success.emit()

static func register_error_callback(method: Callable) -> void:
	_instance.on_error.connect(method)

static func register_success_callback(method: Callable) -> void:
	_instance.on_success.connect(method)
	

func _exit_tree() -> void:
	if SD_Network.is_server():
		data.save()
