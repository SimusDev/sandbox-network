@tool
extends EditorPlugin

func _enable_plugin() -> void:
	SimusNetSettings.get_or_create()
	

func _disable_plugin() -> void:
	# Remove autoloads here.
	pass

func _enter_tree() -> void:
	add_autoload_singleton("SimusNetSingleton", "res://addons/SimusNet/singletons/s_SimusNetSingleton.tscn")

func _exit_tree() -> void:
	remove_autoload_singleton("SimusNetSingleton")
