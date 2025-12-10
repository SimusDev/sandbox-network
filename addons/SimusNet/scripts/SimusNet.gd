@static_unload
extends RefCounted
class_name SimusNet

static var __instance: SimusNet

static var singleton: SimusNetSingleton

static func setup(peer: MultiplayerPeer) -> SimusNet:
	singleton.peer = peer
	return __instance
