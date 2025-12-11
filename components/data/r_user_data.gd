extends Resource
class_name R_UserData

const PASSWORD_MAX_LENGTH: int = 16
const NAME_MAX_LENGTH: int = 16

@export var name: String
@export var password: String
@export var peer: int = SD_Network.SERVER_ID

var active: bool = false
