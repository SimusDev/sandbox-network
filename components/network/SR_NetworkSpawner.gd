extends SD_NetworkSpawner
class_name SR_NetworkSpawner

static func _serialize_global(object: Object, data: Dictionary) -> void:
	var instance: I_ObjectInstance = I_ObjectInstance.find_in(object)
	if instance:
		data.ioi = instance.serialize()

static func _deserialize_global(object: Object, data: Dictionary) -> void:
	if data.has("ioi"):
		I_ObjectInstance.deserialize(data.ioi, object)
