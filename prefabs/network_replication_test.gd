extends Node3D

func _ready() -> void:
	
	if SD_Network.is_server():
		$AnimationPlayer.play("idle")

func test() -> void:
	pass

func _on_timer_timeout() -> void:
	if SD_Network.is_server():
		test()
