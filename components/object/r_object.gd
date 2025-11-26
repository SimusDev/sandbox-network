extends SD_NetworkedResource
class_name R_Object

static var _references: Dictionary[String, R_Object] = {}
static var _reference_list: Array[R_Object] = []

@export var id: String
@export var tab: R_Tab
@export var icon: Texture

func get_default_tab() -> R_Tab:
	return R_Tab.get_default()

static func get_references() -> Dictionary[String, R_Object]:
	return _references

static func get_reference_list() -> Array[R_Object]:
	return _reference_list

static func find_by_id(obj_id: String) -> R_Object:
	return _references.get(obj_id)

func register() -> void:
	if not tab:
		tab = get_default_tab()
	
	if id.is_empty():
		id = resource_path.get_basename().get_file()
	
	if tab:
		if !tab.id.is_empty():
			id = tab.id + ":" + id
		
		tab._objects.append(self)
	
	if _references.has(id):
		id += "_"
	
	_references[id] = self
	_reference_list.append(self)
	
	SD_Console.i().write_info("%s registered: %s" % [get_script().get_global_name(), id])
	
	net_id = id
	
	SD_Network.singleton.cache.cache_resource(self)
	
	super()
	

func unregister() -> void:
	_references.erase(id)
	_reference_list.erase(self)
	
	SD_Console.i().write_warning("%s unregistered: %s" % [get_script().get_global_name(), id])
	
	if tab:
		tab._objects.erase(self)
	
	super()

static func unregister_all() -> void:
	for i in get_reference_list():
		i.unregister()
