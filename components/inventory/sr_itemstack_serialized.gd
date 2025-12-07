extends Resource
class_name SR_ItemStackSerialized

var _data: Dictionary = {} 

static func serialize(from: SR_ItemStack) -> SR_ItemStackSerialized:
	var serialized := SR_ItemStackSerialized.new()
	serialized._data = from.serialize()
	return serialized

static func serialize_from_object(object: R_WorldObject) -> SR_ItemStackSerialized:
	var item := SR_ItemStack.create(object)
	var serialized: SR_ItemStackSerialized = serialize(item)
	SD_Nodes.fast_queue_free(item)
	return serialized

func deserialize() -> SR_ItemStack:
	return SR_ItemStack.deserialize(_data)
