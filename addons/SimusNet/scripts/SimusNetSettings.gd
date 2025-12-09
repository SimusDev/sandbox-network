extends Resource
class_name SimusNetSettings

const PATH: String = "res://simusnet.tres"

static func get_or_create() -> SimusNetSettings:
	var file: Resource = ResourceLoader.load(PATH)
	if file:
		return file
	
	var settings: SimusNetSettings = SimusNetSettings.new()
	ResourceSaver.save(settings, PATH)
	return settings
