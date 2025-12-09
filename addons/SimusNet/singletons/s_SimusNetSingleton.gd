extends Node

enum CHANNELS {
	PLAYER = 100,
	
}

@export var rpc: SNTrunkRPC

var api: SceneMultiplayer
var peer: MultiplayerPeer

func _ready() -> void:
	SimusNet.singleton = self
	SimusNet.__instance = SimusNet.new()
	
	api = SceneMultiplayer.new()
	get_tree().set_multiplayer(api)
	
	for i in get_children():
		if i is SNTrunk:
			i.singleton = self
			i._initialized()
