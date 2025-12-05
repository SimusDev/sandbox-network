@tool
extends Node3D
class_name ViewModelRoot3D

#region SEX
##ПРИВЕТ СОНЕК ТУТ КРЧ Я ХЗ ДЕЛАТЬ ИЛИ НЕ ДЕЛАТЬ МБ ТЫ ХОЧЕШЬ С НУЛЯ КРУЧЕ СДЕЛАТЬ ВОООТ НУ КРЧ ХЗ ВОТ
#endregion

@export var editor: bool = false
@export var authorative_visibility: bool = false
@export var type: R_ViewModel.TYPE = R_ViewModel.TYPE.WORLD
@export var object: R_WorldObject : set = set_object
@export_tool_button("Refresh") var _refresh_tb = _refresh
@export var viewmodel: R_ViewModel : set = set_viewmodel

@export var root_node: Node = null

@export_group("Transform")
@export var reset_transform: bool = false
@export var default_position: Vector3 = Vector3.ZERO
@export var default_rotation: Vector3 = Vector3.ZERO
@export var default_scale: Vector3 = Vector3.ONE

@export_group("References")
@export var inventory: SR_Inventory
@export var placeholder: R_ViewModel
@export var view_node: Node = null

signal on_update()

static var local: ViewModelRoot3D

func get_root_node() -> Node:
	if root_node:
		return root_node
	return self

var _slot: SR_InventorySlot

func _refresh() -> void:
	set_object(object)

func _ready() -> void:
	if !Engine.is_editor_hint():
		if authorative_visibility:
			get_root_node().visible = SD_Network.is_authority(self)
	
	if not placeholder:
		placeholder = load("res://Games/source_game/components/viewmodel/default.tres")
	
	if Engine.is_editor_hint():
		return
	
	if not inventory:
		inventory = SR_Inventory.find_above(self)
	
	if not inventory:
		return
	
	if type == R_ViewModel.TYPE.VIEW:
		if SR_Playable.find_above(self) or root_node is SR_Entity:
			if SD_Network.is_authority(self):
				local = self
	
	
	if !inventory.is_initialized:
		await inventory.initialized
	
	if !inventory.root.is_node_ready():
		await inventory.root.ready
	
	_slot_selected(inventory.get_selected_slot())
	inventory.slot_updated_for_viewmodel.connect(_slot_selected)


func _slot_selected(slot: SR_InventorySlot) -> void:
	if not slot:
		return
	
	_update_slot(slot)

func _update_slot(slot: SR_InventorySlot) -> void:
	if not slot:
		return
	
	if !slot == inventory.get_selected_slot():
		return
	
	var item: SR_ItemStack = slot.get_item()
	if item:
		viewmodel = item.object.viewmodel
	else:
		viewmodel = null

func update_viewmodel() -> void:
	if reset_transform:
		position = default_position
		rotation = default_rotation
		scale = default_scale
	
	if not viewmodel:
		if is_instance_valid(view_node):
			SD_Nodes.fast_queue_free(view_node)
			view_node = null
			on_update.emit()
		return
	
	var prefab: PackedScene = null
	
	var view: R_View3D = viewmodel.view
	if type == R_ViewModel.TYPE.WORLD:
		view = viewmodel.world
	
	if view:
		prefab = view.prefab
	else:
		prefab = object.prefab
	
	if is_instance_valid(view_node):
		if view_node.get_parent():
			view_node.get_parent().remove_child(view_node)
		view_node.queue_free()
		if get_tree() and Engine.is_editor_hint():
			await get_tree().create_timer(0.5).timeout
	
	if prefab:
		view_node = prefab.instantiate()
		view_node.name = "prefab"
	else:
		var mesh3d: MeshInstance3D = MeshInstance3D.new()
		view_node = mesh3d
		mesh3d.mesh = view.mesh
		view_node.name = "mesh"
	
	
	if !Engine.is_editor_hint():
		if object:
			object.set_in(view_node)
		
		if inventory:
			var slot: SR_InventorySlot = inventory.get_selected_slot()
			if slot:
				var item: SR_ItemStack = slot.get_item()
				if item:
					SD_Components.append_to(view_node, item)
	
	view_node.set_multiplayer_authority(get_multiplayer_authority())
	
	get_root_node().add_child(view_node)
	if view_node is Node3D and view:
		view_node.position = view.position
		view_node.rotation = view.rotation
		view_node.scale = view.scale
	
	
	if Engine.is_editor_hint():
		if get_tree():
			view_node.owner = get_tree().edited_scene_root
	
	on_update.emit()

func set_viewmodel(resource: R_ViewModel) -> void:
	if !editor and Engine.is_editor_hint():
		return
	
	viewmodel = resource
	update_viewmodel()

func set_object(reference: R_WorldObject) -> void:
	object = reference
	if object:
		viewmodel = reference.viewmodel
	
