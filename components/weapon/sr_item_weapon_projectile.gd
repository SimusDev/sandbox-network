extends SR_Item
class_name SR_ItemWeaponProjectile

signal event_fire
signal event_reload
signal event_inspect

var _fire_timer: Timer

var weapon: R_WeaponProjectile

@export var entity:Node3D

func _item_ready() -> void:
	weapon = object as R_WeaponProjectile
	
	_fire_timer = Timer.new()
	_fire_timer.process_callback = Timer.TIMER_PROCESS_PHYSICS
	_fire_timer.one_shot = true
	add_child(_fire_timer)
	
	SD_Network.register_functions([
		reload,
	])
	
	
	_init_states()

var state_idle: SD_FiniteState
var state_fire: SD_FiniteState
var state_reload: SD_FiniteState

func _init_states() -> void:
	state_idle = state_machine.create_state("idle")
	state_fire = state_machine.create_state("fire")
	state_reload = state_machine.create_state("reload")

func _on_state_enter(state: SD_FiniteState) -> void:
	print('state enter: ', state)
	
	match state:
		state_reload:
			event_reload.emit()
		

func _on_state_exit(state: SD_FiniteState) -> void:
	print('state exit: ', state)

func _local_input(event: InputEvent) -> void:
	super(event)
	
	if event.is_action_pressed(&"item_inspect"):
		inspect()
	
	elif event.is_action_pressed(&"weapon_reload"):
		network.call_func(reload)

func is_reloading() -> bool:
	return state_reload.is_active()

func is_idle() -> bool:
	return state_idle.is_active()

func reload() -> void:
	if is_idle():
		state_reload.switch().set_timeout(weapon.reload_time, state_idle)

func inspect() -> void:
	event_inspect.emit()

func _process(_delta: float) -> void:
	if is_reloading():
		return
	
	if is_using:
		fire()
	else:
		state_idle.switch()

func fire() -> void:
	if _fire_timer.time_left > 0:
		return
	
	_play_sound()
	_spawn_bullet()
	
	state_fire.switch()
	
	event_fire.emit()
	
	_fire_timer.start(weapon.get_fire_delay())

func _play_sound() -> void:
	weapon.sound_fire.play_locally_attached(self)

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
