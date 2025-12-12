extends Node2D

@export var objects: Array[SimusNetObject]

func _ready() -> void:
	for i in objects:
		i.create_instance()
	
	SimusNetEvents.event_active_status_changed.listen(_active_status_changed)
	
	#SimusNetRPC.register([_test_rpc])

func _on_timer_timeout() -> void:
	if SimusNetConnection.is_server():
		SimusNetRPC.invoke_all(_test_rpc)

func _test_rpc() -> void:
	print("recieved rpc from server!!!")

func _active_status_changed() -> void:
	$CanvasLayer.visible = !SimusNetConnection.is_active()

func _on_host_pressed() -> void:
	SimusNetConnectionENet.create_server(8080)

func _on_connect_pressed() -> void:
	SimusNetConnectionENet.create_client(%LineEdit.text, 8080)
