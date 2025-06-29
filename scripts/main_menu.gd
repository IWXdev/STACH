extends Control

@onready var Play = $VBoxContainer/Button
@onready var Exit = $VBoxContainer/Button3

func _on_play_pressed() -> void:
	$selection.play()
	$Timer.start()
	
func _on_timer_timeout() -> void:
	if Play.pressed:
		get_tree().change_scene_to_file("res://scenes/scene_show.tscn")


func _on_about_pressed() -> void:
	$selection.play()


func _on_exit_pressed() -> void:
	$selection.play()
	get_tree().quit()
