extends Node3D
class_name SR_Item

@export var object: R_WorldObject
@export var use_cooldown: float = 0.0

var network: SD_NetworkFunctionCaller

var level: SR_Level3D

var state_machine: SD_FiniteStateMachine
var input: SD_NodeInput

var is_using: bool = false

func _enter_tree() -> void:
	level = SR_Level3D.find_level(self)

func _ready() -> void:
	input = SD_NodeInput.new()
	input.multiplayer_authorative = true
	input.on_input.connect(_local_input)
	input.set_multiplayer_authority(get_multiplayer_authority())
	add_child(input)
	
	state_machine = SD_FiniteStateMachine.new()
	state_machine.server_authority = true
	state_machine.name = "fsm"
	state_machine.state_enter.connect(_on_state_enter)
	state_machine.state_exit.connect(_on_state_exit)
	add_child(state_machine)
	
	SD_Network.register_function(__pressed_net)
	SD_Network.register_function(__released_net)
	
	network = SD_NetworkFunctionCaller.new("item")
	
	_item_ready()

func _on_state_enter(state: SD_FiniteState) -> void:
	pass

func _on_state_exit(state: SD_FiniteState) -> void:
	pass

func _item_ready() -> void:
	pass

func _local_input(event: InputEvent) -> void:
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
