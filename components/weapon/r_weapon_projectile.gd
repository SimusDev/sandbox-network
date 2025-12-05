extends R_Weapon
class_name R_WeaponProjectile

@export var projectile: R_Projectile
@export var fire_rate_rpm: float = 600.0
@export var reload_time: float = 3.0
@export var sound_fire: R_Sound3D

func get_fire_delay() -> float:
	return 60.0 / fire_rate_rpm
