extends Control
class_name ui_SR_InventoryWindow

@export var container: Control

@export var player_inventory: bool = false

var _player: SR_Playable
var _inventory: SR_Inventory

@export var interface: SD_UIInterfaceMenu

func _ready() -> void:
	pass

func _update_all() -> void:
	if not _inventory.is_initialized:
		await _inventory.initialized
	
	for i in container.get_children():
		i.get_parent().remove_child(i)
		i.queue_free()
	
	for slot in _inventory.get_slots():
		if slot.can_select():
			continue
		
		ui_SR_Slot.create(container, _inventory, slot)

func set_inventory(new: SR_Inventory) -> void:
	if _inventory == new:
		return
	
	_player.inventory.inventory_closed.connect(_on_closed)
	_inventory = new
	_update_all()

func _on_closed(the_closed: SR_Inventory) -> void:
	if the_closed == _inventory:
		already_closed = true
		$SD_UIInterfaceMenu.close()

func _on_sd_ui_interface_menu_closed() -> void:
	if already_closed:
		return
	
	_player.inventory.request_open_or_close_inventory(_inventory, false)
	already_closed = true

func _on_tree_exited() -> void:
	_player.inventory.request_open_or_close_inventory(_inventory, false)

var already_closed: bool = false
