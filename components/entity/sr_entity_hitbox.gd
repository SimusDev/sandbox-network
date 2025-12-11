@tool
extends Area3D
class_name SR_EntityHitbox

@export var health: W_EntityHealth
@export var damage_multiplier: float = 1.0

func _ready() -> void:
	if not Engine.is_editor_hint():
		if !SD_Network.is_server():
			queue_free()
			return
	
	monitoring = false
	priority = SR_Collisions.PRIORITIES.HITBOX
	collision_priority = SR_Collisions.PRIORITIES.HITBOX
	SR_Collisions.clear_and_set_body_collision(self, SR_Collisions.LAYERS.HITBOX)
	
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node3D) -> void:
	if body is SR_Projectile3D:
		health.apply_damage(body.object.damage * damage_multiplier)
