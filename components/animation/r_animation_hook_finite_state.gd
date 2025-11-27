extends R_AnimationHook
class_name R_AnimationHookFiniteState

@export var name: StringName

func init() -> void:
	var machine: SD_FiniteStateMachine = target as SD_FiniteStateMachine
	machine.get_state_by_name(name).on_enter.connect(apply)
	

static func create(state_name: String) -> R_AnimationHookFiniteState:
	var a := R_AnimationHookFiniteState.new()
	a.name = state_name
	return a
