extends SD_Event
class_name SR_Event

static var _events: SR_Events

static func get_by_script(script: Script) -> SR_Event:
	return _events.get_by_script(script)
