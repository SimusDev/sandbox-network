extends Resource
class_name I_ObjectInstance

var object: R_WorldObject
var owner: Object

var parent: Object

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

func spawn() -> I_ObjectInstance:
	parent.add_child(owner)
	return self

func despawn() -> I_ObjectInstance:
	owner.queue_free()
	return self

func set_global_position(position: Variant) -> void:
	if owner is Node3D:
		owner.global_position = SR_GameWorld3D.get_position_or_node3d_position_globally(position)

func get_global_position() -> Vector3:
	if owner is Node3D:
		return owner.global_position
	return Vector3.ZERO

func set_global_rotation(rotation: Variant) -> void:
	if owner is Node3D:
		owner.global_rotation = SR_GameWorld3D.get_rotation_or_node3d_rotation_globally(rotation)

func get_global_rotation() -> Vector3:
	if owner is Node3D:
		return owner.global_rotation
	return Vector3.ZERO
