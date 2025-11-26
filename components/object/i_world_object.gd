extends Resource
class_name I_ObjectInstance

var object: R_WorldObject
var owner: Object

func set_in(object: Object) -> void:
	if owner:
		return
		
	object.set_meta("I_ObjectInstance", self)
	owner = object

static func find_in(object: Node) -> I_ObjectInstance:
	if object.has_meta("I_ObjectInstance"):
		return object.get_meta("I_ObjectInstance")
	return null

func serialize() -> Array:
	var array: Array = []
	array.append(SD_NetworkSerializer.parse(object))
	return array

static func deserialize(serialized: Array, object: Object = null) -> I_ObjectInstance:
	var instance := I_ObjectInstance.new()
	instance.object = SD_NetworkDeserializer.parse(serialized[0])
	
	if object:
		instance.set_in(object)
	
	return instance
