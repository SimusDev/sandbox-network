extends SimusNetSingletonChild
class_name SimusNetRPC

enum TRANSFER_MODE {
	RELIABLE = MultiplayerPeer.TransferMode.TRANSFER_MODE_RELIABLE,
	UNRELIABLE = MultiplayerPeer.TransferMode.TRANSFER_MODE_UNRELIABLE,
	UNRELIABLE_ORDERED = MultiplayerPeer.TransferMode.TRANSFER_MODE_UNRELIABLE_ORDERED,
}

static var _instance: SimusNetRPC

static var _stream_peer: StreamPeerBuffer = StreamPeerBuffer.new()

@export var _processor: SimusNetRPCProccessor

const RPC_BYTE_SIZE: int = 2

static func register(callables: Array[Callable], config := SimusNetRPCConfig.new()) -> void:
	for function in callables:
		SimusNetIdentity.register(function.get_object())
		SimusNetRPCConfig._append_to(function, config)

func initialize() -> void:
	singleton.api.peer_packet.connect(_recieve_rpc_from_peer)
	_stream_peer.big_endian = true
	_instance = self

func _recieve_rpc_from_peer(id: int, bytes: PackedByteArray) -> void:
	_stream_peer.clear()
	_stream_peer.seek(0)
	
	_stream_peer.data_array = bytes
	
	var partial_data: Array = _stream_peer.get_partial_data(SimusNetIdentity.BYTE_SIZE)
	var identity_bytes: PackedByteArray = partial_data[1]
	
	var identity: SimusNetIdentity = SimusNetIdentity.deserialize_unique_id(identity_bytes)
	if !identity:
		logger.push_error("identity with %s ID not found on your instance. failed to call rpc." % SimusNetIdentity.deserialize_unique_id_into_int(partial_data))
		return
		
	var method_id: int = _stream_peer.get_u16()
	
	var rpc_handler: SimusNetRPCConfigHandler = SimusNetRPCConfigHandler.get_or_create(identity.owner)
	var callables: Array[Callable] = rpc_handler._list.keys()
	var callable: Variant = callables.get(method_id)
	if !callable:
		logger.push_error("(identity ID: %s): callable with %s ID not found. failed to call rpc." % [identity.get_unique_id(), method_id])
		return
	
	var config: SimusNetRPCConfig = SimusNetRPCConfig.try_find_in(callable)
	if !config._validate():
		return
	
	var args: Array = []
	if bytes.size() > RPC_BYTE_SIZE + identity_bytes.size():
		args = _stream_peer.get_var()
	
	callable.callv(args)
	
	#print("identity: ", identity.get_unique_id(), " / method: ", method_id)
	

func _validate_callable(callable: Callable) -> SimusNetRPCConfig:
	var object: Object = callable.get_object()
	var config: SimusNetRPCConfig = SimusNetRPCConfig.try_find_in(callable)
	if !config:
		logger.push_error("cant invoke rpc (%s), failed to find rpc config for %s" % [callable, object])
		return null
	
	var rpc_valide: bool = config._validate()
	if rpc_valide:
		return config
	
	return null

static func invoke(callable: Callable, ...args: Array) -> void:
	_instance._invoke(callable, args)

static func invoke_all(callable: Callable, ...args: Array) -> void:
	callable.callv(args)
	_instance._invoke(callable, args)

func _invoke(callable: Callable, args: Array) -> void:
	if !SimusNetConnection.is_active():
		return
	
	var config: SimusNetRPCConfig = _validate_callable(callable)
	if !config:
		return
	
	for id in SimusNetConnection.get_connected_peers():
		_invoke_on_without_validating(id, callable, args, config)
	

func _invoke_on_without_validating(peer: int, callable: Callable, args: Array, config: SimusNetRPCConfig) -> void:
	var object: Object = callable.get_object()
	
	var bytes: PackedByteArray = await _serialize_bytes(callable, args, config)
	
	singleton.api.send_bytes(bytes)

static func invoke_on(peer: int, callable: Callable, ...args: Array) -> void:
	_instance._invoke_on(peer, callable, args)

static func invoke_on_server(callable: Callable, ...args: Array) -> void:
	_instance._invoke_on(SimusNetConnection.SERVER_ID, callable, args)

func _invoke_on(peer: int, callable: Callable, args: Array) -> void:
	if SimusNetConnection.get_unique_id() == peer:
		callable.callv(args)
		return
	
	var config: SimusNetRPCConfig = _validate_callable(callable)
	if !config:
		return
	
	_invoke_on_without_validating(peer, callable, args, config)

func _serialize_bytes(callable: Callable, args: Array, config: SimusNetRPCConfig) -> PackedByteArray:
	_stream_peer.clear()
	_stream_peer.seek(0)
	
	var object: Object = callable.get_object()
	var identity: SimusNetIdentity = SimusNetIdentity.try_find_in(object)
	if !identity.is_ready:
		await identity.on_ready
	
	var bytes_unique_id: PackedByteArray = await identity.serialize_unique_id() 
	
	_stream_peer.put_partial_data(bytes_unique_id)
	_stream_peer.put_u16(config.unique_id)
	
	if !args.is_empty():
		_stream_peer.put_var(args)
	
	return _stream_peer.data_array
