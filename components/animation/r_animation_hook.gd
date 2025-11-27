extends Resource
class_name R_AnimationHook

var target: Object
var animator: SR_ItemAnimator

@export var animation: StringName
@export var play_instant: bool = true

func init() -> void:
	pass

func apply() -> void:
	if play_instant:
		animator.player.stop()
	animator.player.play(animation)

static func initialize_from(array: Array[R_AnimationHook], _animator: SR_ItemAnimator, _target: Object) -> void:
	if Engine.is_editor_hint():
		return
	
	if _target is Node:
		if !_target.is_node_ready():
			await _target.ready
	
	var new: Array[R_AnimationHook] = []
	
	for i in array:
		new.append(i.duplicate())
	
	array.clear()
	array.append_array(new)
	
	for i in array:
		i.animator = _animator
		i.target = _target
		i.init()
