extends Node
class_name SR_Playable

@export var root: Node

func _ready() -> void:
	if not root:
		root = get_parent()
	
	
