extends Node
class_name SR_Inventory

@export var root: Node

var network: SD_NetworkFunctionCaller = SD_NetworkFunctionCaller.new("inventory")

func _ready() -> void:
	if not root:
		root = get_parent()
	
	SD_Components.append_to(root, self)

static func find_above(node: Node) -> SR_Inventory:
	if node is SR_Inventory:
		return node
	return find_above(node.get_parent())
