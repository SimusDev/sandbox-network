class_name SR_Projectile3D extends Node3D

signal impact

@export var gravity:float = 9.8
@export var drag_force:float = 0.5

var entity:Node3D
#@export var projectile_object:R_Projectile
var damage:float = 55.0
var speed:float = 20.0
var max_distance:float = 1000.0

var bullet_fly_direction:Vector3
var prev_pos:Vector3 = Vector3.ZERO
var current_velocity:Vector3
var total_distance:float = 0.0

var health:float = 100.0
var is_hit:bool = false

func _ready() -> void:
	bullet_fly_direction = -entity.global_transform.basis.z.normalized()
	current_velocity = bullet_fly_direction * speed
	#speed = projectile_object.speed
	#damage = projectile_object.damage
	#max_distance = projectile_object.max_distance


func _physics_process(delta: float) -> void:
	if is_hit:
		return
	
	apply_forces(delta)
	var new_pos:Vector3 = global_position + (current_velocity * delta)
	var distance = prev_pos.distance_to(new_pos)
	total_distance += distance
	
	var query = create_ray(prev_pos, new_pos)
	var result = get_world_3d().direct_space_state.intersect_ray(query)
	
	if result:
		is_hit = true
		new_pos = result.position
		
		var collider:Node3D = result.collider
		_handle_collision(collider, result.position)
		
		if health <= 0.0:
			_destroy()

	global_position = new_pos
	if total_distance > max_distance:
		_destroy()
	prev_pos = new_pos

func create_ray(from:Vector3, to:Vector3) -> PhysicsRayQueryParameters3D:
	var query = PhysicsRayQueryParameters3D.create(from, to)
	query.collide_with_areas = true
	query.collision_mask = (1 << 0 | 1 << 1)
	
	var exclude_nodes:Array = [self]
	query.exclude = exclude_nodes

	return query

func apply_forces(delta:float) -> void:
	current_velocity.y -= gravity * delta
	if speed > 0.0:
		speed -= drag_force * delta
		current_velocity = current_velocity.normalized() * speed
	pass

func _handle_collision(collider:Node3D, hit_position:Vector3) -> void:
	current_velocity *= 0.5
	health -= 20.0
	
	if collider.has_method("apply_damage"):
		collider.apply_damage(damage)
	if collider.is_in_group("penetrable"):
			is_hit = false
	
	impact.emit()
	spawn_impact_effect()

func _destroy() -> void:
	queue_free()

func spawn_impact_effect() -> void:
	pass
