extends Control

@export var _ui: PackedScene

@export var _container: Control

signal selected(spawn: R_PlayerSpawn3D)

func _ready() -> void:
	for i in _container.get_children():
		i.queue_free()
	
	for spawn in R_PlayerSpawn3D.list:
		if !spawn.level:
			continue
		
		var ui: Button = _ui.instantiate()
		_container.add_child(ui)
		ui.pressed.connect(_on_pressed.bind(spawn))
		ui.init(spawn)

func _on_pressed(spawn: R_PlayerSpawn3D) -> void:
	selected.emit(spawn)
