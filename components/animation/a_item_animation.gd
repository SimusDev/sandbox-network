@tool
extends Node
class_name A_ItemAnimation

@export var animator: SR_ItemAnimator

@export var hook: R_AnimationHook

func _ready() -> void:
	if get_parent() is SR_ItemAnimator:
		animator = get_parent()
	
