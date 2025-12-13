extends Node
class_name SR_Playable

@export var entity: SR_LivingEntity
@export var root: Node

static var _local: SR_Playable = null

var level: SR_Level3D

var input: SD_NodeInput

var active: bool = false

var network: SD_NetworkPlayer

static var _local: SR_Playable

func is_local() -> bool:
	return network == SD_NetworkPlayer.get_local()

static func get_local() -> SR_Playable:
	return _local

func _ready() -> void:
	S_EventBus.publish(S_EventBus.event_player_spawn, {"playable": self})
	
	if is_local():
		S_EventBus.publish(S_EventBus.event_player_spawn_local, {"playable": self})
	
	if !root.is_node_ready():
		await root.ready
	
	

func _enter_tree() -> void:
	if not root:
		root = get_parent()
	
	if !root.is_node_ready():
		
		network = SD_NetworkPlayer.find_in(root)
		if SD_Network.is_authority(self):
			_local = self
		
		await root.ready
	
	level = SR_Level3D.find_level(self)
	level._player_entered(self)

func _exit_tree() -> void:
	level._player_exited(self)
	
	if is_queued_for_deletion():
		S_EventBus.publish(S_EventBus.event_player_despawn, {"playable": self})
		
		if is_local():
			S_EventBus.publish(S_EventBus.event_player_despawn_local, {"playable": self})

static func find_above(_node:Node) -> SR_Playable:
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
			if object is R_WorldObject:
				level.instantiate(object).spawn().set_global_position(root)
