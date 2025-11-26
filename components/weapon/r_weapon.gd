extends R_WorldObject
class_name R_Weapon

@export var projectile: R_Projectile
@export var fire_rate_rpm: float = 600.0

func get_fire_delay() -> float:
	return 60.0 / fire_rate_rpm

func get_default_tab() -> R_Tab:
	return R_Tab.create_global("weapon")
