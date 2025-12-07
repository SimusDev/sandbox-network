extends SD_SaveableResource
class_name SR_ServerData

func is_server_authorative() -> bool:
	return true

func get_filename() -> String:
	return "server"

func get_base_path() -> String:
	return "user://server"

func is_encrypted() -> bool:
	return false
