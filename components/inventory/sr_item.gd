extends Node3D
class_name SR_Item

@export var object: R_WorldObject
@export var use_cooldown: float = 0.0

var network: SD_NetFunctionCaller

var level: SR_Level3D

var is_using: bool = false

func _enter_tree() -> void:
	level = SR_Level3D.find_level(self)

func _ready() -> void:
	SD_Network.register_function(__pressed_net)
	SD_Network.register_function(__released_net)
	network = SD_NetFunctionCaller.new()
	network.default_channel = "item"
	add_child.call_deferred(network)
	
	set_process_input(SD_Network.is_authority(self))

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("item_use"):
		request_press()
	
	elif event.is_action_released("item_use"):
		request_release()

func request_press() -> void:
	network.call_func(__pressed_net)

func request_release() -> void:
	network.call_func(__released_net)

func __pressed_net() -> void:
	is_using = true
	_pressed()

func __released_net() -> void:
	is_using = false
	_released()

func _pressed() -> void:
	pass

func _released() -> void:
	pass

static func find_above(node: Node) -> SR_Item:
	if node is SR_Item or node == null:
		return node
	return find_above(node.get_parent())
