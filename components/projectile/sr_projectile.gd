extends RigidBody3D
class_name SR_Projectile3D

var damage: int = 10
var speed: float = 50.0
var max_lifetime: float = 5.0
var owner_id: int = -1

func _ready() -> void:
	gravity_scale = 0.0
	contact_monitor = true
	max_contacts_reported = 1
	
	var timer = Timer.new()
	timer.wait_time = max_lifetime
	timer.one_shot = true
	timer.timeout.connect(_on_timeout)
	add_child(timer)
	timer.start()
	
	apply_central_impulse(-global_transform.basis.z * speed)

func _on_timeout() -> void:
	queue_free()

func _on_body_entered(body) -> void:
	if body.has_method("take_damage") and body != get_owner():
		body.take_damage(damage, owner_id)
	
	spawn_impact_effect()
	queue_free()

func spawn_impact_effect() -> void:
	pass
