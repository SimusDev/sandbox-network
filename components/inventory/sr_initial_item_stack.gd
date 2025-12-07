extends Resource
class_name SR_InitialItemStack

@export var object: R_WorldObject : get = get_object
@export var quantity: int = 1

func get_object() -> R_WorldObject:
	if object:
		return object
	return R_WorldObject.get_placeholder()
