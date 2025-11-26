extends SR_Item
class_name SR_ItemWeapon

signal event_fire
signal event_reload
signal event_inspect

var _fire_timer: Timer

var weapon: R_Weapon

@export var entity:Node3D


func _ready() -> void:
	super()
	
	weapon = object as R_Weapon
	
	
	_fire_timer = Timer.new()
	_fire_timer.process_callback = Timer.TIMER_PROCESS_PHYSICS
	_fire_timer.one_shot = true
	add_child(_fire_timer)

func _input(event: InputEvent) -> void:
	super(event)
	if event.is_action_pressed(&"item_inspect"):
		event_inspect.emit()
	elif event.is_action_pressed(&"weapon_reload"):
		event_reload.emit()


func _process(_delta: float) -> void:
	if is_using:
		fire()

func fire() -> void:
	if _fire_timer.time_left > 0:
		return
	
	_play_sound()
	_spawn_bullet()
	
	event_fire.emit()
	
	_fire_timer.start(weapon.get_fire_delay())

func _play_sound() -> void:
	weapon.sound_fire.play_locally(self)

func _spawn_bullet() -> void:
	var camera:W_FPCSourceLikeCamera = SD_Components.find_first(entity, W_FPCSourceLikeCamera)
	var bullet = level.instantiate_local(weapon.projectile)
	bullet.owner.entity = entity
	bullet.owner.speed = weapon.projectile.speed
	bullet.owner.damage = weapon.projectile.damage
	bullet.owner.max_distance = weapon.projectile.max_distance
	bullet.owner.bullet_fly_direction = -camera.global_transform.basis.z.normalized()
	bullet.spawn()
	
	
	
	bullet.set_global_position(camera)
	bullet.set_global_rotation(camera)
