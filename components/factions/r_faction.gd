extends R_Object
class_name R_Faction

static var list: Array[R_Faction] = []

func get_default_tab() -> R_Tab:
	return R_Tab.create_global("faction")

func _registered() -> void:
	list.append(self)

func _unregistered() -> void:
	list.erase(self)
