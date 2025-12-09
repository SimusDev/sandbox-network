extends SNTrunk
class_name SNTrunkRPC

func _initialized() -> void:
	singleton.api.peer_packet.connect(_on_peer_packet)

func call_rpc(peer: int, method: Callable, args: Array = [], mode: MultiplayerPeer.TransferMode = MultiplayerPeer.TransferMode.TRANSFER_MODE_RELIABLE, channel: int = 0) -> void:
	singleton.api.send_bytes([], peer, mode, channel)

func _on_peer_packet(id: int, packet: PackedByteArray) -> void:
	print(id)
	print(packet)
	
