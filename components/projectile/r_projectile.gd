extends R_WorldObject
class_name R_Projectile

func get_default_tab() -> R_Tab:
	return R_Tab.create_global("projectile")

func get_level_section() -> SR_LevelSection3D:
	return
