extends Resource
class_name SimusNetRPCConfig

var _handler: SimusNetRPCConfigHandler

var _channel: String = SimusNetChannels.DEFAULT
var _transfer_mode: SimusNetRPC.TRANSFER_MODE = SimusNetRPC.TRANSFER_MODE.RELIABLE

var unique_id: int = -1

static func try_find_in(callable: Callable) -> SimusNetRPCConfig:
	var handler: SimusNetRPCConfigHandler = SimusNetRPCConfigHandler.get_or_create(callable.get_object())
	return handler._list.get(callable)

static func _append_to(callable: Callable, config: SimusNetRPCConfig) -> void:
	var handler: SimusNetRPCConfigHandler = SimusNetRPCConfigHandler.get_or_create(callable.get_object())
	config._handler = handler
	handler._list[callable] = config
	config.unique_id = handler._list.size() - 1

#//////////////////////////////////////////////////////////////

func flag_get_channel_id() -> int:
	return SimusNetChannels.get_id(_channel)

func flag_get_transfer_mode() -> SimusNetRPC.TRANSFER_MODE:
	return _transfer_mode

#//////////////////////////////////////////////////////////////

func flag_set_channel(channel: String) -> SimusNetRPCConfig:
	SimusNetChannels.register(channel)
	_channel = channel
	return self

func flag_set_transfer_mode(mode: SimusNetRPC.TRANSFER_MODE) -> SimusNetRPCConfig:
	_transfer_mode = mode
	return self

#//////////////////////////////////////////////////////////////

func flag_set_unreliable() -> SimusNetRPCConfig:
	_transfer_mode = SimusNetRPC.TRANSFER_MODE.UNRELIABLE
	return self

func flag_set_unreliable_ordered() -> SimusNetRPCConfig:
	_transfer_mode = SimusNetRPC.TRANSFER_MODE.UNRELIABLE_ORDERED
	return self

func flag_set_reliable() -> SimusNetRPCConfig:
	_transfer_mode = SimusNetRPC.TRANSFER_MODE.RELIABLE
	return self

#//////////////////////////////////////////////////////////////

func _validate() -> bool:
	return true
