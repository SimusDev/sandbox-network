extends Node
class_name SR_InventorySlotSwitcher

@export var inventory: SR_Inventory

var _input: SD_NodeInput

var _pressed_keys: Array[int] = []
var _keys_to_hook: PackedStringArray = [
	"0",
	"1",
	"2",
	"3",
	"4",
	"5",
	"6",
	"7",
	"8",
	"9",
]

var _slots: Dictionary[int, SR_InventorySlot] = {}

func _ready() -> void:
	if not inventory:
		inventory = SR_Inventory.find_above(self)
	
	if not inventory.is_initialized:
		await inventory.initialized
	
	var id: int = 0
	for i in inventory.get_slots():
		if i.can_select():
			_slots[id] = i
			id += 1
	
	var playable: SR_Playable = SD_Components.find_first(inventory.root, SR_Playable)
	if playable:
		_create_player_input()

func _create_player_input() -> void:
	if !SD_Network.is_authority(self):
		return
	
	_input = SD_NodeInput.new()
	_input.name = "input"
	_input.on_unhandled_input.connect(_on_input)
	add_child(_input)

func _on_input(event: InputEvent) -> void:
	if event is InputEventKey:
		var key: String = OS.get_keycode_string(event.key_label)
		
		if not key in _keys_to_hook:
			return
		
		if event.is_pressed():
			if not _pressed_keys.has(event.key_label):
				_pressed_keys.append(event.key_label)
				
				var index: int = int(key) - 1
				switch(index)
		else:
			_pressed_keys.erase(event.key_label)

func switch(index: int) -> void:
	if !_slots.has(index):
		return
	
	var slot: SR_InventorySlot = _slots.get(index) as SR_InventorySlot
	slot.select()
