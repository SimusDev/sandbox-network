extends Node
class_name SR_InventorySlot

var _inventory: SR_Inventory

var network: SD_NetworkFunctionCaller = SD_NetworkFunctionCaller.new("inventory")

func _enter_tree() -> void:
	_inventory = get_parent()

func _exit_tree() -> void:
	pass
