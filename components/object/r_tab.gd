extends R_Object
class_name R_Tab

#static var _default: R_Tab = preload("res://data/resources/tabs/object.tres")

static var _globals: Dictionary[String, R_Tab] = {}

var _objects: Array[R_Object] = []

static func get_default() -> R_Tab:
	return null

static func get_globals() -> Dictionary[String, R_Tab]:
	return _globals

static func create_global(id: String) -> R_Tab:
	if _globals.has(id):
		return _globals.get(id)
	
	var new := R_Tab.new()
	new.id = id
	new.register()
	_globals[id] = new
	return new

func get_objects() -> Array[R_Object]:
	return _objects
