extends SR_Item
class_name SR_ItemWeapon

signal event_fire
signal event_reload
signal event_inspect

var _fire_timer: Timer

var weapon: R_Weapon

func _ready() -> void:
	super()
	
	weapon = object as R_Weapon
	
	_fire_timer = Timer.new()
	_fire_timer.one_shot = true
	add_child(_fire_timer)

func _process(delta: float) -> void:
	if is_using:
		fire()

func fire() -> void:
	if _fire_timer.time_left > 0:
		return
	
	_spawn_bullet()
	
	event_fire.emit()
	
	_fire_timer.start(weapon.get_fire_delay())

func _spawn_bullet() -> void:
	pass
