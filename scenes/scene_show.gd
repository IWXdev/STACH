extends Node2D


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$Timer.start()
	pass

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
