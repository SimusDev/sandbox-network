extends Resource
class_name SimusNetObject

var _multiplayer_authority: int = SimusNetConnection.SERVER_ID

@export var uuid: Variant : set = set_uuid

var identity: SimusNetIdentity

signal instance_create()
signal instance_delete()

var _is_queued_for_deletion: bool = false

func is_queued_for_deletion() -> bool:
	return _is_queued_for_deletion

func set_uuid(new: Variant) -> SimusNetObject:
	uuid = new
	return self

func set_multiplayer_authority(id: int, recursive: bool = true) -> void:
	_multiplayer_authority = id

func get_multiplayer_authority() -> int:
	return _multiplayer_authority

func create_instance() -> void:
	identity = SimusNetIdentity.register(self, SimusNetIdentitySettings.new().set_unique_id(uuid))
	instance_create.emit()

func delete_instance() -> void:
	_is_queued_for_deletion = true
	instance_delete.emit()

func queue_free() -> void:
	delete_instance()
