extends Node
class_name SR_Entity

@export var root: Node3D
@export var synchronizer: SD_NetPositionSynchronizer

func _ready() -> void:
	SD_Components.append_to(root, self)
	
	if !root:
		root = get_parent()
	
	synchronizer = _create_component(synchronizer, SD_NetPositionSynchronizer, "synchronizer")
	synchronizer.tickrate = 64.0
	synchronizer.node = root

func _create_component(reference: Object, script: GDScript, c_name: String) -> Object:
	if is_instance_valid(reference):
		return
	
	var node: Object = script.new()
	if node is Node:
		node.name = c_name
		node.set_multiplayer_authority(get_multiplayer_authority())
		root.add_child.call_deferred(node)
	return node
