extends Control


func _on_spawn_container_selected(spawn: R_PlayerSpawn3D) -> void:
	var selection: R_UserCharacterSelect = R_UserCharacterSelect.new()
	selection.spawn = spawn
	S_PlayerCharacterSelect.play(selection)
