extends Control

@onready var switcher: SD_UIScreenSwitcher = SD_UIScreenSwitcher.find_above(self)

@onready var l_login: LineEdit = $Panel/VBoxContainer/l_login
@onready var l_password: LineEdit = $Panel/VBoxContainer/l_password

@onready var sd_label: SD_Label = $Panel/SD_Label

var errors: Dictionary[S_PlayerAuth.ERROR, LobbyError] = {
	S_PlayerAuth.ERROR.PASSWORD_EMPTY: LobbyError.new("password can't be empty!", Color.RED),
	S_PlayerAuth.ERROR.INCORRECT_PASSWORD: LobbyError.new("incorrect password!", Color.RED),
	S_PlayerAuth.ERROR.USER_ALREADY_ONLINE: LobbyError.new("user already online!", Color.RED),
}

class LobbyError:
	var message: String
	var color: Color
	
	func _init(msg: String, color: Color = Color.WHITE) -> void:
		self.message = msg
		self.color = color

func _ready() -> void:
	l_login.max_length = R_UserData.NAME_MAX_LENGTH
	l_password.max_length = R_UserData.PASSWORD_MAX_LENGTH
	l_login.text = S_PlayerAuth.get_last_login()
	l_password.text = S_PlayerAuth.get_last_password()
	
	S_PlayerAuth.register_error_callback(_on_error)
	S_PlayerAuth.register_success_callback(_on_success)


func _on_error(error: S_PlayerAuth.ERROR) -> void:
	if error in errors:
		var lobby_error: LobbyError = errors[error]
		throw_message(lobby_error.message, lobby_error.color)

func throw_message(msg: String, color: Color = Color.WHITE) -> void:
	sd_label.font_color = color
	sd_label.text = msg

func _on_success() -> void:
	switcher.switch_by_name("ScreenCharacterSelect")

func _on_b_login_pressed() -> void:
	S_PlayerAuth.request_login(l_login.text, l_password.text)
