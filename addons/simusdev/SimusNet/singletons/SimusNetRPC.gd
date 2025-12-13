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

func _setup_remote_sender(id: int, channel: int) -> void:
	SimusNetRemote.sender_id = id
	SimusNetRemote.sender_channel = SimusNetChannels.get_name_by_id(channel)
	SimusNetRemote.sender_channel_id = channel

static func register(callables: Array[Callable], config := SimusNetRPCConfig.new()) -> void:
	for function in callables:
		SimusNetIdentity.register(function.get_object())
		SimusNetRPCConfig._append_to(function, config)

func initialize() -> void:
	_stream_peer.big_endian = true
	_instance = self

func _processor_recieve_rpc_from_peer(peer: int, channel: int, packet: PackedByteArray) -> void:
	_setup_remote_sender(peer, channel)
	
	_stream_peer.clear()
	_stream_peer.seek(0)
	_stream_peer.data_array = packet
	
	#var identity: SimusNetIdentity = SimusNetIdentity.deserialize_unique_id(identity_bytes)
	#if !identity:
		#logger.push_error("identity with %s ID not found on your instance. failed to call rpc." % SimusNetIdentity.deserialize_unique_id_into_int(identity_bytes))
		#return
	#
	#var object: Object = identity.owner
	#
	#var method_id: int = SimusNetMethods.deserialize(method_bytes)
	#var method_name: String = SimusNetMethods.get_name_by_id(method_id)
	#
	#if peer == SimusNetConnection.SERVER_ID:
		#object.callv(method_name, args)
		#return
	#
	#var rpc_handler: SimusNetRPCConfigHandler = SimusNetRPCConfigHandler.get_or_create(object)
	#var callable: Callable = rpc_handler._list_by_unique_id.get(method_id)
	#if !callable:
		#logger.push_error("(identity ID: %s): callable with %s ID not found. failed to call rpc." % [identity.get_unique_id(), method_id])
		#return
	#
	#var config: SimusNetRPCConfig = SimusNetRPCConfig.try_find_in(callable)
	#if !await config._validate():
		#return
	#
	#callable.callv(args)
	#

func _validate_callable(callable: Callable) -> SimusNetRPCConfig:
	var object: Object = callable.get_object()
	var config: SimusNetRPCConfig = SimusNetRPCConfig.try_find_in(callable)
	if !config:
		logger.push_error("cant invoke rpc (%s), failed to find rpc config for %s" % [callable, object])
		return null
	
	var rpc_valide: bool = await config._validate()
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
	
	var config: SimusNetRPCConfig = await _validate_callable(callable)
	if !config:
		return
	
	for id in SimusNetConnection.get_connected_peers():
		_invoke_on_without_validating(id, callable, args, config)
	

func _invoke_on_without_validating(peer: int, callable: Callable, args: Array, config: SimusNetRPCConfig) -> void:
	_stream_peer.clear()
	_stream_peer.seek(0)
	
	var object: Object = callable.get_object()
	
	var identity: SimusNetIdentity = SimusNetIdentity.try_find_in(object)
	if !identity.is_ready:
		await identity.on_ready
	
	var bytes_unique_id: PackedByteArray = identity.serialize_unique_id() 
	var bytes_method_id: PackedByteArray = config.unique_id_bytes
	
	_stream_peer.put_data(bytes_unique_id)
	_stream_peer.put_data(bytes_method_id)
	
	#if !args.is_empty():
		#var first: Variant = args[0]
		#if args.size() == 1:
			#_stream_peer.put_data(var_to_bytes(first))
		#else:
			#_stream_peer.put_var(args)
		
	
	_stream_peer.put_data(var_to_bytes(args[0]))
	
	#if !args.is_empty():
		#if args.size() == 1:
			#_stream_peer.put_var(args[0])
		#else:
			#_stream_peer.put_var(args)
	
	var bytes: PackedByteArray = _stream_peer.data_array
	
	var function: StringName = _processor._parse_and_get_function(config.flag_get_channel_id(), config.flag_get_transfer_mode())
	var p_callable: Callable = Callable(_processor, function)
	p_callable.rpc_id(peer, bytes)
	


static func invoke_on(peer: int, callable: Callable, ...args: Array) -> void:
	_instance._invoke_on(peer, callable, args)

static func invoke_on_server(callable: Callable, ...args: Array) -> void:
	_instance._invoke_on(SimusNetConnection.SERVER_ID, callable, args)

func _invoke_on(peer: int, callable: Callable, args: Array) -> void:
	var config: SimusNetRPCConfig = await _validate_callable(callable)
	if !config:
		return
	
	if SimusNetConnection.get_unique_id() == peer:
		callable.callv(args)
		_setup_remote_sender(peer, config.flag_get_channel_id())
		return
	
	_invoke_on_without_validating(peer, callable, args, config)
