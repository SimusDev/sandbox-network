extends Control

func _ready() -> void:
	S_EventBus.event_player_spawn_local.published.connect(_on_local_player_spawned)
	S_EventBus.event_player_despawn_local.published.connect(_on_local_player_despawned)

func _on_local_player_spawned() -> void:
	hide()

func _on_local_player_despawned() -> void:
	show()
