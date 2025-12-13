extends RefCounted
class_name SimusNetRPCConfigHandler

var _list: Dictionary[Callable, SimusNetRPCConfig] = {}
var _list_by_unique_id: Dictionary[int, SimusNetRPCConfig] = {}

static func get_or_create(object: Object) -> SimusNetRPCConfigHandler:
	if object.has_meta("SimusNetRPCConfigHandler"):
		return object.get_meta("SimusNetRPCConfigHandler")
	
	var handler := SimusNetRPCConfigHandler.new()
	object.set_meta("SimusNetRPCConfigHandler", handler)
	return handler
