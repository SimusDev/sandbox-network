extends Control

var _player: SR_Playable
var _inventory: SR_Inventory

@export var _container: Control

func _ready() -> void:
	_player = SR_Playable.get_local()
	if not _player:
		return
		
	
	_inventory = SD_Components.find_first(_player.root, SR_Inventory)
	if !_inventory.is_initialized:
		await _inventory.initialized
	
	for i in _inventory.get_slots():
		if i.can_select():
			ui_SR_Slot.create(_container, _inventory, i)
	
