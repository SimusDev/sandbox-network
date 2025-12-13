extends SR_ItemAction
class_name SR_ItemActionDrop

func get_code() -> String:
	return "drop"

func _action_local(item: SR_ItemStack) -> void:
	item.drop()
