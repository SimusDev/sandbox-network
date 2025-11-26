extends SR_Entity
class_name SR_LivingEntity

@export var inventory: SR_Inventory

func _ready() -> void:
	super()
	inventory = _create_component(inventory, SR_Inventory, "inventory")
