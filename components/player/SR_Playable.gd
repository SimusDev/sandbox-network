extends Node
class_name SR_Playable

@export var root: Node

static var _local: SR_Playable = null

var level: SR_Level3D

var input: SD_NodeInput


func _ready() -> void:
	if not root:
		root = get_parent()
	
	level = SR_Level3D.find_level(self)
	
	if SD_Network.is_authority(self):
		_local = self

static func find_above(node:Node) -> SR_Playable:
	return null

static func get_local() -> SR_Playable:
	return _local

func is_local() -> bool:
	return self == get_local()

#test govna. remove this method next time
func _on_commands_on_executed(command: SD_ConsoleCommand) -> void:
	if !SD_Network.is_authority(self):
		return
	
	match command.get_code():
		"level.spawn":
			var object: R_Object = R_Object.find_by_id(command.get_value_as_string())
			for i in R_Object.get_reference_list():
				print(i.id)
			if object is R_WorldObject:
				level.instantiate(object).spawn().set_global_position(root)
