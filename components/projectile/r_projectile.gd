extends R_WorldObject
class_name R_Projectile

@export var damage:float = 55.0
@export var speed:float = 245.0
@export var max_distance:float = 800.0

func get_default_tab() -> R_Tab:
	return R_Tab.create_global("projectile")

func get_level_section() -> SR_LevelSection3D:
	return
