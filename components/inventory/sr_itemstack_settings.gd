extends Resource
class_name SR_ItemStackSettings

@export var stackable: bool = true
@export var stack_size: int = 64
@export var pickable: bool = true
@export var durability: float = 0.0
@export var durability_max: float = 0.0
@export var custom_script: GDScript : get = get_custom_script
@export var actions: Array[SR_ItemAction] = [] : get = get_actions

signal on_action_local(action: SR_ItemAction)

func get_custom_script() -> GDScript:
	if custom_script:
		return custom_script
	return SR_ItemStack

func get_actions() -> Array[SR_ItemAction]:
	return actions

func register() -> void:
	actions.append(SR_ItemActionDrop.new())
	
