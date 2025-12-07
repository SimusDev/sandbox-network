extends Resource
class_name R_UserCharacterSelect

var faction: R_Faction
var spawn: R_PlayerSpawn3D

func serialize() -> Dictionary:
	var result := {}
	
	if faction:
		result.faction = SD_NetworkSerializer.parse(faction)
	
	if spawn:
		result.spawn = SD_NetworkSerializer.parse(spawn)
	
	return result

static func deserialize(data: Dictionary) -> R_UserCharacterSelect:
	var selection := R_UserCharacterSelect.new()
	
	if data.has("faction"):
		selection.faction = SD_NetworkDeserializer.parse(data.faction)
	
	if data.has("spawn"):
		selection.spawn = SD_NetworkDeserializer.parse(data.spawn)
	
	return selection
