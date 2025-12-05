extends Control

@onready var spawn_name: SD_Label = $spawn_name
@onready var icon: TextureRect = $icon

func init(spawn: R_PlayerSpawn3D) -> void:
	icon.texture = spawn.icon
	spawn_name.text = "(level: %s) " % [spawn.level.name] + spawn.id
