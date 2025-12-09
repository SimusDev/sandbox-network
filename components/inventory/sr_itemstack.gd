extends Node
class_name SR_ItemStack

var object: R_WorldObject

@export var _data: Dictionary = {}

var _network: SD_NetworkFunctionCaller = SD_NetworkFunctionCaller.new("inventory")

@onready var _replicator: SD_NetworkReplicator

var _inventory: SR_Inventory
var _slot: SR_InventorySlot

func get_inventory() -> SR_Inventory:
	return _inventory

func get_slot() -> SR_InventorySlot:
	return _slot

var quantity: int = 1 : set = set_quantity
var durability: float = 0.0 : set = set_durability
var durability_max: float = 0.0 : set = set_durability_max

signal on_quantity_changed()
signal on_durability_changed()
signal on_durability_max_changed()

func set_quantity(value: int) -> void:
	quantity = value
	on_quantity_changed.emit()

func set_durability(value: float) -> void:
	durability = value
	on_durability_changed.emit()

func set_durability_max(value: float) -> void:
	durability_max = value
	on_durability_max_changed.emit()

func _ready() -> void:
	SD_Network.register_object(self)
	set_multiplayer_authority(SD_Network.SERVER_ID)
	_replicator = SD_NetworkReplicator.attach_or_get(self)
	_replicator.set_vars_channel("inventory")
	
	
	
	_replicator.register_vars([
		"quantity",
		"durability",
		"durability_max"
	])
	
	

func _enter_tree() -> void:
	pass

func _exit_tree() -> void:
	pass

func serialize() -> Dictionary:
	var result: Dictionary = {}
	result.c = SD_Variables.get_class_from(self)
	result.q = quantity
	result.d = durability
	result.dm = durability_max
	_serialize_custom(result)
	return result

static func deserialize(data: Dictionary) -> SR_ItemStack:
	var instance: SR_ItemStack = SD_Variables.instantiate_class(data.c)
	instance.quantity = data.q
	instance.durability = data.d
	instance.durability_max = data.dm
	instance._deserialize_custom(data)
	return instance

func _serialize_custom(data: Dictionary) -> void:
	pass

func _deserialize_custom(data: Dictionary) -> void:
	pass
