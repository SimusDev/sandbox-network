extends Node
class_name SR_Events

static var i: SR_Events

var _events: Dictionary[Script, SR_Events] = {
	#S_EventItemUse: S_EventItemUse.new(),
	#S_EventWeaponMeleeImpact: S_EventWeaponMeleeImpact.new(),
	#S_EventGunFire: S_EventGunFire.new(),
	#S_EventGunFirePre: S_EventGunFirePre.new(),
	#S_EventExplosionAfter: S_EventExplosionAfter.new(),
	#S_EventExplosionPre: S_EventExplosionPre.new(),
	#S_EventExplosionParticlesCreated: S_EventExplosionParticlesCreated.new(),
	#S_EventInteract: S_EventInteract.new(),
	#S_EventObjectSpawned: S_EventObjectSpawned.new(),
	#S_EventObjectDespawned: S_EventObjectDespawned.new(),
	#S_EventObjectDeleted: S_EventObjectDeleted.new(),
	#S_EventObjectCreated: S_EventObjectCreated.new(),
	#S_EventDeath: S_EventDeath.new(),
	#S_EventDeathLocal: S_EventDeathLocal.new(),
	#S_EventPlayerSpawned: S_EventPlayerSpawned.new(),
	#S_EventPlayerDespawned: S_EventPlayerDespawned.new(),
	#S_EventPlayerUICreated: S_EventPlayerUICreated.new(),
	#S_EventInventoryClosed: S_EventInventoryClosed.new(),
	#S_EventInventoryOpened: S_EventInventoryOpened.new(),
}

static func get_by_script(script: Script) -> SR_Event:
	return get_instance()._events.get(script)

static func get_instance() -> SR_Events:
	return i

func _enter_tree() -> void:
	SR_Event._events = self
	i = self
