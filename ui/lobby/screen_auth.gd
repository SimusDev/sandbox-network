extends Control

@onready var switcher: SD_UIScreenSwitcher = SD_UIScreenSwitcher.find_above(self)

@onready var l_login: LineEdit = $Panel/VBoxContainer/l_login
@onready var l_password: LineEdit = $Panel/VBoxContainer/l_password

@onready var sd_label: SD_Label = $Panel/SD_Label

func _ready() -> void:
	l_login.max_length = R_UserData.NAME_MAX_LENGTH
	l_password.max_length = R_UserData.PASSWORD_MAX_LENGTH
	l_login.text = S_PlayerAuth.get_last_login()
	l_password.text = S_PlayerAuth.get_last_password()
	
	S_PlayerAuth.register_error_callback(_on_error)
	S_PlayerAuth.register_success_callback(_on_success)

func _on_error(error: S_PlayerAuth.ERROR) -> void:
	match error:
		S_PlayerAuth.ERROR.PASSWORD_EMPTY:
			sd_label.text = "password can't be empty!"
		S_PlayerAuth.ERROR.INCORRECT_PASSWORD:
			sd_label.text = "incorrect password!"
			

func _on_success() -> void:
	switcher.switch_by_name("ScreenCharacterSelect")

func _on_b_login_pressed() -> void:
	S_PlayerAuth.request_login(l_login.text, l_password.text)
