extends SR_ServerData
class_name SR_ServerAuthData

@export var users: Array[R_UserData] = []

static var instance: SR_ServerAuthData

static func find_by_peer_id(id: int) -> R_UserData:
	for user in instance.users:
		if user.peer == id:
			return user
	return null

static func find_by_name(name: String) -> R_UserData:
	for user in instance.users:
		if user.name == name:
			return user
	return null

func get_filename() -> String:
	return "auth"
