class_name SR_ItemAction extends Resource

@export var code: String = "" : get = get_code

func _init() -> void:
	pass

func get_code() -> String:
	if code:
		return code
	return "action"

func _action(item: SR_ItemStack) -> void:
	pass

func _action_server(item: SR_ItemStack) -> void:
	pass

func _action_local(item: SR_ItemStack) -> void:
	item.drop()
