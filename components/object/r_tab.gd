extends R_Object
class_name R_Tab

#static var _default: R_Tab = preload("res://data/resources/tabs/object.tres")

static var _globals: Dictionary[String, R_Tab] = {}

var _objects: Array[R_Object] = []

static func get_default() -> R_Tab:
	return null

static func get_globals() -> Dictionary[String, R_Tab]:
	return _globals

static func create_global(tid: String) -> R_Tab:
	if _globals.has(tid):
		return _globals.get(tid)
	
	var new := R_Tab.new()
	new.id = tid
	new.register()
	_globals[tid] = new
	return new

func get_objects() -> Array[R_Object]:
	return _objects
