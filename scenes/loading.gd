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

func start_game() -> void:
	get_tree().change_scene_to_file.call_deferred("res://scenes/game.tscn")

func _on_host_pressed() -> void:
	SD_Network.create_server(port)
	start_game()

func _on_connect_pressed() -> void:
	ip = $LineEdit.text
	SD_Network.create_client(ip, port)
