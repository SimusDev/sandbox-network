extends Node
class_name SR_InventorySlot

var _inventory: SR_Inventory

func _enter_tree() -> void:
	_inventory = get_parent()

func _exit_tree() -> void:
	pass
