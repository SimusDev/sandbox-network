extends Control

func _ready() -> void:
	S_PlayerCharacterSelect.register_success_callback(_on_character_select_success)

func _on_character_select_success() -> void:
	hide()
