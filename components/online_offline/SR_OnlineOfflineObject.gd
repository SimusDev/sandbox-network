extends RefCounted
class_name SR_OnlineOfflineObject

var owner: Node3D

var _static: bool = true
var _online: bool = true

signal status_changed()

func set_static(value: bool = true) -> SR_OnlineOfflineObject:
	_static = value
	return self

func set_online(value: bool = true) -> SR_OnlineOfflineObject:
	_online = value
	
	if not _online:
		owner.process_mode = Node.PROCESS_MODE_DISABLED
	else:
		owner.process_mode = Node.PROCESS_MODE_INHERIT
		
	
	status_changed.emit()
	
	return self

func set_offline(value: bool = true) -> SR_OnlineOfflineObject:
	return set_online(!value)

func is_online() -> bool:
	return _online

func is_offline() -> bool:
	return !_online

func is_static() -> bool:
	return _static

func is_dynamic() -> bool:
	return !_static

static func get_or_create(target: Node3D) -> SR_OnlineOfflineObject:
	if target.has_meta("SR_OnlineOfflineObject"):
		return target.get_meta("SR_OnlineOfflineObject")
	
	var object := SR_OnlineOfflineObject.new()
	object.owner = target
	target.set_meta("SR_OnlineOfflineObject", object)
	
	return object
