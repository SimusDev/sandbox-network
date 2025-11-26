extends Node3D
class_name SR_LevelSection3D

var _level: SR_Level3D

var _list: Dictionary

var networked: bool = true : set = set_networked

func get_local() -> SR_LevelSection3D:
	return _level._sections.get("l_" + name)

func set_networked(value: bool) -> void:
	networked = value
	if is_instance_valid(_level):
		if value:
			_level.get_spawner().register(self)
		else:
			_level.get_spawner().unregister(self)

func get_level() -> SR_Level3D:
	return _level

func _ready() -> void:
	pass

func _enter_tree() -> void:
	_level = SR_Level3D.find_level(self)
	_level._sections[name] = self
	
	if networked:
		get_level().get_spawner().register(self)

func _exit_tree() -> void:
	if networked:
		get_level().get_spawner().unregister(self)
	_level._sections.erase(name)
