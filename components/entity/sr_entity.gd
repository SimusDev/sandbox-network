extends Node
class_name SR_Entity

@export var root: Node3D

func _ready() -> void:
	SD_Components.append_to(root, self)
	
	if !root:
		root = get_parent()
	
	SD_NetworkReplicator.attach_or_get(root).set_transform_tickrate(64)
	
	if root is PhysicsBody3D:
		SR_Collisions.clear_body_collisions(root)
		SR_Collisions.set_body_collision(root, SR_Collisions.LAYERS.WORLD, false)
		SR_Collisions.set_body_collision(root, SR_Collisions.LAYERS.ENTITY, false)
		SR_Collisions.set_body_collision(root, SR_Collisions.LAYERS.ZONE)
		
	

func _create_component(reference: Object, script: GDScript, c_name: String) -> Object:
	if is_instance_valid(reference):
		return
	
	var node: Object = script.new()
	if node is Node:
		node.name = c_name
		node.set_multiplayer_authority(get_multiplayer_authority())
		root.add_child.call_deferred(node)
	return node
