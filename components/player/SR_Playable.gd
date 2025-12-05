extends Node
class_name SR_Playable

@export var root: Node

var level: SR_Level3D

var input: SD_NodeInput

var active: bool = false

var network: SD_NetworkPlayer

func _ready() -> void:
	pass

func _enter_tree() -> void:
	if not root:
		root = get_parent()
	
	if !root.is_node_ready():
		
		network = SD_NetworkPlayer.find_in(root)
		
		await root.ready
	
	level = SR_Level3D.find_level(self)
	level._player_entered(self)

func _exit_tree() -> void:
	level._player_exited(self)

static func find_above(node:Node) -> SR_Playable:
	return null

#test govna. remove this method next time
func _on_commands_on_executed(command: SD_ConsoleCommand) -> void:
	if !SD_Network.is_authority(self):
		return
	
	match command.get_code():
		"level.spawn":
			var object: R_Object = R_Object.find_by_id(command.get_value_as_string())
			if object is R_WorldObject:
				level.instantiate(object).spawn().set_global_position(root)
