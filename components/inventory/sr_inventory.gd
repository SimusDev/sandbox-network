@icon("res://addons/simusdev/components/inventory/icon_inv.png")
class_name SR_Inventory extends Node


@export var root: Node
@export var debug: bool = false
@export var private: bool = false

var _slots: Array[SR_InventorySlot] = []
var _items: Array[SR_ItemStack] = []

var _selected_slot: SR_InventorySlot = null

@export var initial_slots: int = 36

var is_initialized: bool = false

signal initialized()

var _is_full: bool = false

signal item_added(item: SR_ItemStack)
signal item_removed(item: SR_ItemStack)
signal slot_selected(slot: SR_InventorySlot)
signal slot_deselected(slot: SR_InventorySlot)
signal slot_updated(slot: SR_InventorySlot)
signal slot_updated_for_viewmodel(slot: SR_InventorySlot)
#signal craft_queue_add(craft: SR_CraftQueue)
#signal craft_queue_remove(craft: SR_CraftQueue)

signal inventory_opened(inventory: SR_Inventory)
signal inventory_closed(inventory: SR_Inventory)

#var _craft_queue: Array[SR_CraftQueue] = []
#
#var ray: SR_InteractRay

var _events: Dictionary[String, SD_Event] = {}

var net_caller: SD_NetFunctionCaller

#//////////////////////////////////////////////////////////////
var player: SR_Playable
#var effects: SR_Effects

func event_get_or_create(code: String) -> SD_Event:
	if _events.has(code):
		return _events[code]
	
	var event: SD_Event = SD_Event.new()
	event.debug = false
	_events[code] = event
	return event

static func find_above(from: Node) -> SR_Inventory:
	if from is SR_GameWorld3D:
		return null
	
	var founded: SR_Inventory = SD_Components.find_first(from, SR_Inventory)
	if founded:
		return founded
	return find_above(from.get_parent())

func debug_print(text, category: int = SD_ConsoleCategories.INFO) -> void:
	if debug:
		SimusDev.console.write("%s: %s" % [str(self), str(text)], category)

func _ready() -> void:
	net_caller = SD_NetFunctionCaller.new()
	net_caller.default_channel = "inventory"
	add_child(net_caller)
	
	SD_Network.register_object(self)
	SD_Network.register_functions([
		__send,
		_drop_server,
		_action_request,
		_item_move_to_net,
		_select_slot_server,
		__request_open_or_close_inventory_net
	])
	
	SD_Network.cache_functions([
		_select_slot_local,
	])
	
	if not root:
		root = get_parent()
	
	SD_Components.append_to(root, self)
	
	if !root.is_node_ready():
		await root.ready
	
	player = SR_Playable.find_above(self)
	#
	#effects = SR_Effects.new()
	#effects.inventory = self
	#effects.name = "effects"
	#effects.player = player
	#root.add_child.call_deferred(effects)
	
	if not SD_Network.is_server():
		synchronize_all()
		return
	
	var slots_to_create: int = initial_slots - get_slots().size()
	for i in slots_to_create:
		var slot := SR_InventorySlot.new()
		add_child(slot)
	
	_select_initial_slot()
	_try_initialize()
	
	#ray = SD_Components.find_first(root, SR_InteractRay)

func get_selected_slot() -> SR_InventorySlot:
	return _selected_slot

func _select_initial_slot() -> void:
	for slot in get_slots():
		if slot.can_select():
			_selected_slot = slot
			break

func _try_initialize() -> void:
	if is_initialized:
		return
	
	initialized.emit()
	is_initialized = true
	debug_print("inventory initialized!")

func get_slots() -> Array[SR_InventorySlot]:
	return _slots

func get_items() -> Array[SR_ItemStack]:
	return _items

func synchronize_all() -> void:
	if SD_Network.is_server():
		return
	
	net_caller.call_func_on_server(__send)

func _clear_inventory_slots() -> void:
	for i in get_children():
		if i is SR_InventorySlot:
			i.get_parent().remove_child(i)
			i.queue_free()
	

func __send() -> void:
	var slots: Array = []
	
	for slot in get_slots():
		slots.append(slot.serialize())
	
	net_caller.call_func_on(SD_Network.get_remote_sender_id(), __recieve, [slots, _slots.find(_selected_slot)])

func __recieve(slots: Array, slot_index: int) -> void:
	_clear_inventory_slots()
	
	for serialized in slots:
		var slot: SR_InventorySlot = SR_InventorySlot.deserialize(serialized)
		add_child(slot)
	
	_selected_slot = _slots.get(slot_index)
	
	debug_print("synced all slots and items! %s")
	_try_initialize()

func select_slot(slot: SR_InventorySlot) -> void:
	if not slot:
		return
	
	if is_initialized:
		net_caller.call_func_on_server(_select_slot_server, [slot])

func _select_slot_server(slot: SR_InventorySlot) -> void:
	if SD_Network.is_server():
		if is_instance_valid(slot) and is_initialized:
			if slot.can_select():
				net_caller.call_func(_select_slot_local, [slot])
			else:
				debug_print("cant select slot without selectable attribute!", SD_ConsoleCategories.ERROR)
			

func _select_slot_local(slot: SR_InventorySlot) -> void:
	if is_instance_valid(slot):
		slot_deselected.emit(slot)
		_selected_slot = slot
		slot_selected.emit(_selected_slot)
		_selected_slot.update()
		_selected_slot.update_for_viewmodel()
		debug_print("slot selected %s" % str(slot))

func item_action_request(item: SR_ItemStack, action: SR_ItemAction) -> void:
	net_caller.call_func_on_server(_action_request, [item, action])

func _action_request(item: SR_ItemStack, action_class: SR_ItemAction) -> void:
	if is_instance_valid(item):
		if action_class:
			action_class._action(item)
			action_class._action_server(item)
			net_caller.call_func_except_self(_do_action_net, [item, SR_Network.serialize_resource(action_class)])
			net_caller.call_func_on(SD_Network.get_remote_sender_id(), _do_action_local, [item, SR_Network.serialize_resource(action_class)])

func _do_action_net(item: SR_ItemStack, serialized: Variant) -> void:
	var action_class: SR_ItemAction = SR_Network.deserialize_resource(serialized)
	if action_class:
		action_class._action(item)

func _do_action_local(item: SR_ItemStack, serialized: Variant) -> void:
	var action_class: SR_ItemAction = SR_Network.deserialize_resource(serialized)
	if action_class:
		action_class._action_local(item)



func is_full() -> bool:
	var full: int = 0
	for slot in get_slots():
		if slot.get_item():
			full += 1
	return full >= get_slots().size()

func pick_up(object: Object) -> void:
	if not SD_Network.is_server():
		return
	
	if is_full():
		debug_print("cant pickup, inventory is full!")
		return
	
	var target: Object = object
	#if object is SR_Hitbox:
		#target = object.health.target
	#elif object is SR_Interactable:
		#target = object.root
	
	
	if !is_instance_valid(target):
		return
	
	var source_object: R_WorldObject = R_WorldObject.find_in(target)
	if source_object:
		if !source_object.get_itemstack().pickable:
			return
		
		var items: Array[SR_ItemStackSerialized] = SR_ItemStack.find_serialized_items_in(target)
		if items.is_empty():
			add_item(SR_ItemStackSerialized.serialize_from_object(source_object).deserialize())
			SD_Nodes.fast_queue_free(target)
		else:
			for i in items:
				var item: SR_ItemStack = i.deserialize()
				add_item(item)
				
			SD_Nodes.fast_queue_free(target)
			
				

func get_free_slot() -> SR_InventorySlot:
	for s in get_slots():
		if not s.get_item():
			return s
	return null

func get_items_by_object(obj: R_Object) -> Array[SR_ItemStack]:
	var result: Array[SR_ItemStack] = []
	for i in _items:
		if i.object == obj:
			result.append(i)
	return result

func add_item(item: SR_ItemStack) -> void:
	if not SD_Network.is_server():
		return
	
	var free_slot: SR_InventorySlot = get_free_slot()
	if !free_slot:
		debug_print("cant add item, inventory is full!")
		SD_Nodes.fast_queue_free(item)
		return
	
	var serialized: Variant = item.serialize()
	if !item.is_inside_tree() and !item.is_node_ready():
		SD_Nodes.fast_queue_free(item)
	
	var server: SR_ItemStack = _add_item_net(serialized)
	if is_instance_valid(server):
		if !server.is_queued_for_deletion():
			net_caller.call_func_except_self(_add_item_net, [server.serialize()])
	
		sort_stackables(item.object)
	item_added.emit()

func _add_item_net(serialized: Variant) -> SR_ItemStack:
	var item := SR_ItemStack.deserialize(serialized)
	if get_free_slot():
		get_free_slot().add_child(item)
	return item

func remove_item(item: SR_ItemStack) -> void:
	if not SD_Network.is_server():
		return
	
	if get_items().has(item):
		net_caller.call_func(_remove_item_net, [item])
	item_removed.emit()

func _remove_item_net(item: SR_ItemStack) -> void:
	if is_instance_valid(item):
		SD_Nodes.fast_queue_free(item)

func drop(item: SR_ItemStack) -> void:
	if get_items().has(item):
		net_caller.call_func_on_server(_drop_server, [item])
		SD_Nodes.fast_queue_free(item)

func stack_items(stackable: SR_ItemStack, item: SR_ItemStack) -> SR_ItemStack:
	if SD_Network.is_server():
		if get_items().has(stackable) and get_items().has(item):
			
			if !stackable.object.get_itemstack().stackable or !item.object.get_itemstack().stackable:
				return null
			
			if stackable.object == item.object:
				item.set_quantity(item.get_quantity() + stackable.get_quantity())
				remove_item(stackable)
				return item
	return null

func sort_stackables(object: R_Object) -> void:
	if SD_Network.is_server():
		var items: Array[SR_ItemStack] = get_items_by_object(object)
		while items.size() > 1:
			var first: SR_ItemStack = items[0]
			var second: SR_ItemStack = items[1]
			items.erase(first)
			stack_items(second, first)

func sort() -> void:
	if SD_Network.is_server():
		for item in get_items():
			sort_stackables(item.object)

func _drop_server(item: SR_ItemStack) -> void:
	if get_items().has(item):
		var drop: R_Object = item.object.create().instantiate()
		#if ray:
			#var pos: Vector3 = ray.global_position + ray.target_position.rotated(Vector3(0, 1, 0), ray.global_rotation.y)
			#var pos = player.root.global_position
			#drop.set_global_position(pos)
		#else:
		drop.set_global_position_from(root)
		
		item.serialize_and_append_to(drop.source)
		remove_item(item)

#func craft(recipe: R_Recipe) -> void:
	#SR_Crafting.as_node().request(self, recipe)

func item_move_to(item: SR_ItemStack, slot: SR_InventorySlot) -> void:
	if get_items().has(item):
		net_caller.call_func_on_server(_item_move_to_net, [item, slot])

func _item_move_to_net(item: SR_ItemStack, slot: SR_InventorySlot) -> void:
	if not is_instance_valid(slot):
		return
	
	if not get_items().has(item):
		return
	
	if item.get_slot() == slot:
		return
	
	if not slot.is_free():
		debug_print("item can moved only in empty slot!")
		return
	
	if !slot.can_move_item_to_this(item):
		return
	
	var to_inv: SR_Inventory = slot.get_inventory()
	
	#if to_inv == self:
		#debug_print("cant move item to private inventory!")
		#return
	
	#print(to_inv)
	#print(get_opened_inventories())
	#if not get_opened_inventories().has(to_inv):
		#print("cant move item to another inventory slot, first, open the inventory.")
		#debug_print("cant move item to another inventory slot, first, open the inventory.")
		#return
	
	net_caller.call_func(_item_move_to_local, [item.get_path(), slot.get_path()])

func _item_move_to_local(item_path: NodePath, to_path: NodePath) -> void:
	var item: SR_ItemStack = get_node_or_null(item_path)
	var to: SR_InventorySlot = get_node_or_null(to_path)
	if item and to:
		var to_inv: SR_Inventory = to.get_inventory()
		item.reparent(to)

var _opened: Array[SR_Inventory] = []

func get_opened_inventories() -> Array[SR_Inventory]:
	return _opened

func request_open_or_close_inventory(inventory: SR_Inventory, open: bool = true) -> void:
	net_caller.call_func_on_server(__request_open_or_close_inventory_net, [inventory, open])

func __request_open_or_close_inventory_net(inventory: SR_Inventory, open: bool) -> void:
	if open:
		open_inventory(inventory)
	else:
		close_inventory(inventory)

func open_inventory(inventory: SR_Inventory) -> void:
	if !SD_Network.is_server() or !is_instance_valid(inventory):
		return
	
	#if inventory.private and inventory != self:
		#return
	
	net_caller.call_func(_net_open_or_close_inventory, [inventory, true])

func close_inventory(inventory: SR_Inventory) -> void:
	if !SD_Network.is_server() or !is_instance_valid(inventory):
		return
	
	net_caller.call_func(_net_open_or_close_inventory, [inventory, false])

func _net_open_or_close_inventory(inventory: SR_Inventory, opened: bool) -> void:
	if !inventory:
		return
	
	if opened:
		if !_opened.has(inventory):
			_opened.append(inventory)
			inventory_opened.emit(inventory)
			SR_EventInventoryOpened.as_event().inventory = self
			SR_EventInventoryOpened.as_event().publish()
	else:
		if _opened.has(inventory):
			_opened.erase(inventory)
			inventory_closed.emit(inventory)
			SR_EventInventoryClosed.as_event().inventory = self
			SR_EventInventoryClosed.as_event().publish()
			
