@tool
extends Area3D
class_name SR_Teleport3D

@export var level: R_Level3D : set = set_level
@export_file_path var level_id: String
@export var to_position: Vector3 = Vector3.ZERO

func set_level(resource: R_Level3D) -> void:
	level = null
	if resource:
		level_id = ResourceUID.path_to_uid(resource.resource_path)
		

func _ready() -> void:
	monitorable = false
	
	SR_Collisions.clear_body_collisions(self)
	SR_Collisions.set_body_collision(self, SR_Collisions.LAYERS.ZONE)
	
	if Engine.is_editor_hint():
		return
	
	if SD_Network.is_server():
		body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node3D) -> void:
	if SD_Network.is_server():
		(load(level_id) as R_Level3D).get_local_instance().teleport(body)
		body.position = to_position
