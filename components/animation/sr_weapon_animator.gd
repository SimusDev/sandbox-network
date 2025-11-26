@tool
extends SR_ItemAnimator
class_name SR_WeaponAnimator

func _begin_reset() -> void:
	hooks.append(R_AnimationHookSignal.create("event_fire"))
	hooks.append(R_AnimationHookSignal.create("event_reload"))
	hooks.append(R_AnimationHookSignal.create("event_inspect"))
	
	
