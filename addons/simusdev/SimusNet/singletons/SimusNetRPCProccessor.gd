@tool
extends Node
class_name SimusNetRPCProccessor

@export_multiline var source: String = ""
@export_tool_button("Generate Code") var _tb_generate_code = _generate_code

func _generate_code() -> void:
	var source: String = source
	var generated: String = ""
	for id in SimusNetChannels.MAX:
		var str_id: String = str(id)
		generated += source % [str_id, str_id, str_id, str_id, str_id, str_id, str_id, str_id, str_id]
	
	DisplayServer.clipboard_set(generated)

@rpc("reliable", "call_remote", "any_peer")
func _test_rpc(data: Variant) -> void:
	pass

@rpc("reliable", "call_remote", "any_peer")
func _test_rpc2(data: Variant, data2: Variant) -> void:
	pass

func _recieve(peer: int, channel: int, packet: PackedByteArray) -> void:
	get_parent()._processor_recieve_rpc_from_peer(peer, channel, packet)

func _parse_and_get_function(channel: int, transfer: SimusNetRPC.TRANSFER_MODE) -> String:
	return "_rpc_%s_%s" % [transfer, channel]

#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 0)
func _rpc_0_0(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 0, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 0)
func _rpc_1_0(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 0, packet)

@rpc("any_peer", "call_remote", "reliable", 0)
func _rpc_2_0(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 0, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 1)
func _rpc_0_1(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 1, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 1)
func _rpc_1_1(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 1, packet)

@rpc("any_peer", "call_remote", "reliable", 1)
func _rpc_2_1(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 1, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 2)
func _rpc_0_2(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 2, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 2)
func _rpc_1_2(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 2, packet)

@rpc("any_peer", "call_remote", "reliable", 2)
func _rpc_2_2(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 2, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 3)
func _rpc_0_3(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 3, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 3)
func _rpc_1_3(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 3, packet)

@rpc("any_peer", "call_remote", "reliable", 3)
func _rpc_2_3(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 3, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 4)
func _rpc_0_4(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 4, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 4)
func _rpc_1_4(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 4, packet)

@rpc("any_peer", "call_remote", "reliable", 4)
func _rpc_2_4(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 4, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 5)
func _rpc_0_5(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 5, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 5)
func _rpc_1_5(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 5, packet)

@rpc("any_peer", "call_remote", "reliable", 5)
func _rpc_2_5(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 5, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 6)
func _rpc_0_6(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 6, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 6)
func _rpc_1_6(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 6, packet)

@rpc("any_peer", "call_remote", "reliable", 6)
func _rpc_2_6(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 6, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 7)
func _rpc_0_7(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 7, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 7)
func _rpc_1_7(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 7, packet)

@rpc("any_peer", "call_remote", "reliable", 7)
func _rpc_2_7(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 7, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 8)
func _rpc_0_8(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 8, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 8)
func _rpc_1_8(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 8, packet)

@rpc("any_peer", "call_remote", "reliable", 8)
func _rpc_2_8(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 8, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 9)
func _rpc_0_9(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 9, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 9)
func _rpc_1_9(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 9, packet)

@rpc("any_peer", "call_remote", "reliable", 9)
func _rpc_2_9(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 9, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 10)
func _rpc_0_10(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 10, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 10)
func _rpc_1_10(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 10, packet)

@rpc("any_peer", "call_remote", "reliable", 10)
func _rpc_2_10(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 10, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 11)
func _rpc_0_11(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 11, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 11)
func _rpc_1_11(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 11, packet)

@rpc("any_peer", "call_remote", "reliable", 11)
func _rpc_2_11(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 11, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 12)
func _rpc_0_12(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 12, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 12)
func _rpc_1_12(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 12, packet)

@rpc("any_peer", "call_remote", "reliable", 12)
func _rpc_2_12(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 12, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 13)
func _rpc_0_13(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 13, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 13)
func _rpc_1_13(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 13, packet)

@rpc("any_peer", "call_remote", "reliable", 13)
func _rpc_2_13(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 13, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 14)
func _rpc_0_14(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 14, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 14)
func _rpc_1_14(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 14, packet)

@rpc("any_peer", "call_remote", "reliable", 14)
func _rpc_2_14(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 14, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 15)
func _rpc_0_15(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 15, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 15)
func _rpc_1_15(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 15, packet)

@rpc("any_peer", "call_remote", "reliable", 15)
func _rpc_2_15(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 15, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 16)
func _rpc_0_16(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 16, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 16)
func _rpc_1_16(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 16, packet)

@rpc("any_peer", "call_remote", "reliable", 16)
func _rpc_2_16(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 16, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 17)
func _rpc_0_17(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 17, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 17)
func _rpc_1_17(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 17, packet)

@rpc("any_peer", "call_remote", "reliable", 17)
func _rpc_2_17(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 17, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 18)
func _rpc_0_18(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 18, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 18)
func _rpc_1_18(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 18, packet)

@rpc("any_peer", "call_remote", "reliable", 18)
func _rpc_2_18(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 18, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 19)
func _rpc_0_19(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 19, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 19)
func _rpc_1_19(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 19, packet)

@rpc("any_peer", "call_remote", "reliable", 19)
func _rpc_2_19(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 19, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 20)
func _rpc_0_20(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 20, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 20)
func _rpc_1_20(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 20, packet)

@rpc("any_peer", "call_remote", "reliable", 20)
func _rpc_2_20(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 20, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 21)
func _rpc_0_21(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 21, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 21)
func _rpc_1_21(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 21, packet)

@rpc("any_peer", "call_remote", "reliable", 21)
func _rpc_2_21(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 21, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 22)
func _rpc_0_22(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 22, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 22)
func _rpc_1_22(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 22, packet)

@rpc("any_peer", "call_remote", "reliable", 22)
func _rpc_2_22(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 22, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 23)
func _rpc_0_23(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 23, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 23)
func _rpc_1_23(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 23, packet)

@rpc("any_peer", "call_remote", "reliable", 23)
func _rpc_2_23(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 23, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 24)
func _rpc_0_24(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 24, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 24)
func _rpc_1_24(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 24, packet)

@rpc("any_peer", "call_remote", "reliable", 24)
func _rpc_2_24(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 24, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 25)
func _rpc_0_25(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 25, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 25)
func _rpc_1_25(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 25, packet)

@rpc("any_peer", "call_remote", "reliable", 25)
func _rpc_2_25(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 25, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 26)
func _rpc_0_26(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 26, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 26)
func _rpc_1_26(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 26, packet)

@rpc("any_peer", "call_remote", "reliable", 26)
func _rpc_2_26(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 26, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 27)
func _rpc_0_27(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 27, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 27)
func _rpc_1_27(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 27, packet)

@rpc("any_peer", "call_remote", "reliable", 27)
func _rpc_2_27(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 27, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 28)
func _rpc_0_28(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 28, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 28)
func _rpc_1_28(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 28, packet)

@rpc("any_peer", "call_remote", "reliable", 28)
func _rpc_2_28(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 28, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 29)
func _rpc_0_29(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 29, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 29)
func _rpc_1_29(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 29, packet)

@rpc("any_peer", "call_remote", "reliable", 29)
func _rpc_2_29(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 29, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 30)
func _rpc_0_30(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 30, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 30)
func _rpc_1_30(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 30, packet)

@rpc("any_peer", "call_remote", "reliable", 30)
func _rpc_2_30(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 30, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 31)
func _rpc_0_31(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 31, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 31)
func _rpc_1_31(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 31, packet)

@rpc("any_peer", "call_remote", "reliable", 31)
func _rpc_2_31(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 31, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 32)
func _rpc_0_32(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 32, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 32)
func _rpc_1_32(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 32, packet)

@rpc("any_peer", "call_remote", "reliable", 32)
func _rpc_2_32(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 32, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 33)
func _rpc_0_33(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 33, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 33)
func _rpc_1_33(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 33, packet)

@rpc("any_peer", "call_remote", "reliable", 33)
func _rpc_2_33(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 33, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 34)
func _rpc_0_34(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 34, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 34)
func _rpc_1_34(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 34, packet)

@rpc("any_peer", "call_remote", "reliable", 34)
func _rpc_2_34(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 34, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 35)
func _rpc_0_35(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 35, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 35)
func _rpc_1_35(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 35, packet)

@rpc("any_peer", "call_remote", "reliable", 35)
func _rpc_2_35(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 35, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 36)
func _rpc_0_36(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 36, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 36)
func _rpc_1_36(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 36, packet)

@rpc("any_peer", "call_remote", "reliable", 36)
func _rpc_2_36(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 36, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 37)
func _rpc_0_37(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 37, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 37)
func _rpc_1_37(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 37, packet)

@rpc("any_peer", "call_remote", "reliable", 37)
func _rpc_2_37(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 37, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 38)
func _rpc_0_38(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 38, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 38)
func _rpc_1_38(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 38, packet)

@rpc("any_peer", "call_remote", "reliable", 38)
func _rpc_2_38(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 38, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 39)
func _rpc_0_39(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 39, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 39)
func _rpc_1_39(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 39, packet)

@rpc("any_peer", "call_remote", "reliable", 39)
func _rpc_2_39(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 39, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 40)
func _rpc_0_40(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 40, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 40)
func _rpc_1_40(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 40, packet)

@rpc("any_peer", "call_remote", "reliable", 40)
func _rpc_2_40(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 40, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 41)
func _rpc_0_41(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 41, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 41)
func _rpc_1_41(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 41, packet)

@rpc("any_peer", "call_remote", "reliable", 41)
func _rpc_2_41(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 41, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 42)
func _rpc_0_42(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 42, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 42)
func _rpc_1_42(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 42, packet)

@rpc("any_peer", "call_remote", "reliable", 42)
func _rpc_2_42(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 42, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 43)
func _rpc_0_43(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 43, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 43)
func _rpc_1_43(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 43, packet)

@rpc("any_peer", "call_remote", "reliable", 43)
func _rpc_2_43(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 43, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 44)
func _rpc_0_44(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 44, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 44)
func _rpc_1_44(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 44, packet)

@rpc("any_peer", "call_remote", "reliable", 44)
func _rpc_2_44(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 44, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 45)
func _rpc_0_45(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 45, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 45)
func _rpc_1_45(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 45, packet)

@rpc("any_peer", "call_remote", "reliable", 45)
func _rpc_2_45(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 45, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 46)
func _rpc_0_46(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 46, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 46)
func _rpc_1_46(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 46, packet)

@rpc("any_peer", "call_remote", "reliable", 46)
func _rpc_2_46(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 46, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 47)
func _rpc_0_47(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 47, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 47)
func _rpc_1_47(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 47, packet)

@rpc("any_peer", "call_remote", "reliable", 47)
func _rpc_2_47(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 47, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 48)
func _rpc_0_48(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 48, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 48)
func _rpc_1_48(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 48, packet)

@rpc("any_peer", "call_remote", "reliable", 48)
func _rpc_2_48(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 48, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 49)
func _rpc_0_49(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 49, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 49)
func _rpc_1_49(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 49, packet)

@rpc("any_peer", "call_remote", "reliable", 49)
func _rpc_2_49(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 49, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 50)
func _rpc_0_50(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 50, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 50)
func _rpc_1_50(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 50, packet)

@rpc("any_peer", "call_remote", "reliable", 50)
func _rpc_2_50(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 50, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 51)
func _rpc_0_51(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 51, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 51)
func _rpc_1_51(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 51, packet)

@rpc("any_peer", "call_remote", "reliable", 51)
func _rpc_2_51(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 51, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 52)
func _rpc_0_52(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 52, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 52)
func _rpc_1_52(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 52, packet)

@rpc("any_peer", "call_remote", "reliable", 52)
func _rpc_2_52(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 52, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 53)
func _rpc_0_53(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 53, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 53)
func _rpc_1_53(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 53, packet)

@rpc("any_peer", "call_remote", "reliable", 53)
func _rpc_2_53(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 53, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 54)
func _rpc_0_54(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 54, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 54)
func _rpc_1_54(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 54, packet)

@rpc("any_peer", "call_remote", "reliable", 54)
func _rpc_2_54(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 54, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 55)
func _rpc_0_55(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 55, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 55)
func _rpc_1_55(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 55, packet)

@rpc("any_peer", "call_remote", "reliable", 55)
func _rpc_2_55(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 55, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 56)
func _rpc_0_56(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 56, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 56)
func _rpc_1_56(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 56, packet)

@rpc("any_peer", "call_remote", "reliable", 56)
func _rpc_2_56(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 56, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 57)
func _rpc_0_57(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 57, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 57)
func _rpc_1_57(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 57, packet)

@rpc("any_peer", "call_remote", "reliable", 57)
func _rpc_2_57(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 57, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 58)
func _rpc_0_58(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 58, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 58)
func _rpc_1_58(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 58, packet)

@rpc("any_peer", "call_remote", "reliable", 58)
func _rpc_2_58(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 58, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 59)
func _rpc_0_59(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 59, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 59)
func _rpc_1_59(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 59, packet)

@rpc("any_peer", "call_remote", "reliable", 59)
func _rpc_2_59(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 59, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 60)
func _rpc_0_60(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 60, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 60)
func _rpc_1_60(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 60, packet)

@rpc("any_peer", "call_remote", "reliable", 60)
func _rpc_2_60(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 60, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 61)
func _rpc_0_61(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 61, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 61)
func _rpc_1_61(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 61, packet)

@rpc("any_peer", "call_remote", "reliable", 61)
func _rpc_2_61(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 61, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 62)
func _rpc_0_62(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 62, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 62)
func _rpc_1_62(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 62, packet)

@rpc("any_peer", "call_remote", "reliable", 62)
func _rpc_2_62(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 62, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 63)
func _rpc_0_63(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 63, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 63)
func _rpc_1_63(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 63, packet)

@rpc("any_peer", "call_remote", "reliable", 63)
func _rpc_2_63(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 63, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 64)
func _rpc_0_64(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 64, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 64)
func _rpc_1_64(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 64, packet)

@rpc("any_peer", "call_remote", "reliable", 64)
func _rpc_2_64(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 64, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 65)
func _rpc_0_65(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 65, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 65)
func _rpc_1_65(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 65, packet)

@rpc("any_peer", "call_remote", "reliable", 65)
func _rpc_2_65(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 65, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 66)
func _rpc_0_66(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 66, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 66)
func _rpc_1_66(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 66, packet)

@rpc("any_peer", "call_remote", "reliable", 66)
func _rpc_2_66(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 66, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 67)
func _rpc_0_67(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 67, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 67)
func _rpc_1_67(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 67, packet)

@rpc("any_peer", "call_remote", "reliable", 67)
func _rpc_2_67(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 67, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 68)
func _rpc_0_68(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 68, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 68)
func _rpc_1_68(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 68, packet)

@rpc("any_peer", "call_remote", "reliable", 68)
func _rpc_2_68(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 68, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 69)
func _rpc_0_69(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 69, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 69)
func _rpc_1_69(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 69, packet)

@rpc("any_peer", "call_remote", "reliable", 69)
func _rpc_2_69(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 69, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 70)
func _rpc_0_70(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 70, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 70)
func _rpc_1_70(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 70, packet)

@rpc("any_peer", "call_remote", "reliable", 70)
func _rpc_2_70(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 70, packet)


#//////////////////////////////////////////////////////////////////////////////////////////////////
@rpc("any_peer", "call_remote", "unreliable", 71)
func _rpc_0_71(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 71, packet)

@rpc("any_peer", "call_remote", "unreliable_ordered", 71)
func _rpc_1_71(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 71, packet)

@rpc("any_peer", "call_remote", "reliable", 71)
func _rpc_2_71(packet: PackedByteArray) -> void:
	_recieve(multiplayer.get_remote_sender_id(), 71, packet)
