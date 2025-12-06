extends S_GameSingletonBase
class_name S_EventBus

static var event_player_spawn := EVENT_PlayerSpawn.new()
static var event_player_despawn := EVENT_PlayerDespawn.new()
static var event_player_spawn_local := EVENT_PlayerSpawnLocal.new()
static var event_player_despawn_local := EVENT_PlayerDespawnLocal.new()

static func publish(event: EVENT, properties: Dictionary[String, Variant]) -> void:
	for p in properties:
		event.set(p, properties[p])
	event.publish()
