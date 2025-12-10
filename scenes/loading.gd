extends CanvasLayer

@export var port: int = 7777
@export var ip: String = "localhost"

func _ready() -> void:
	SD_Network.singleton.on_connected_to_server.connect(start_game)
	#
	#if OS.get_cmdline_args().has("--server"):
		#SD_Network.create_server(port)
		#start_game()
	#else:
		#SD_Network.create_client(ip, port)
	
	
	var peer: StreamPeer = StreamPeerBuffer.new()
	var instance_id: int = get_instance_id()
	var method_id: int = 10
	
	peer.big_endian = true
	
	print("instance: ", instance_id)
	print("method: ", method_id)
	
	peer.put_32(instance_id)  
	peer.put_u16(method_id)   
	
	peer.seek(0)
	
	var received_instance_id: int = peer.get_32() 
	var received_method_id: int = peer.get_u16() 
	
	print("recieved instance: ", received_instance_id)
	print("recieved method: ", received_method_id)
	

func start_game() -> void:
	get_tree().change_scene_to_file.call_deferred("res://scenes/game.tscn")

func _on_host_pressed() -> void:
	SD_Network.create_server(port)
	start_game()

func _on_connect_pressed() -> void:
	ip = $LineEdit.text
	SD_Network.create_client(ip, port)
