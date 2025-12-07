extends R_Object
class_name R_WorldObject

@export var prefab: PackedScene : get = get_prefab
@export var viewmodel: R_ViewModel = null

@export_group("ItemStack")
@export var itemstack: SR_ItemStackSettings = null : get = get_itemstack

func get_prefab() -> PackedScene:
	return prefab

func register() -> void:
	super()
	SD_Network.singleton.cache.cache_resource(prefab)

static func find_in(node: Node) -> R_WorldObject:
	if node.has_meta("R_WorldObject"):
		return node.get_meta("R_WorldObject")
	return null
