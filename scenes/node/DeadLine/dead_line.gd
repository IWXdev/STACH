extends Area2D

@onready var animation : AnimationPlayer = $AnimationPlayer


func _on_body_entered(body: Node2D):
	if body.is_in_group("player"):
		body.hit(100.0, Vector2(0, -0))
#		get_tree().reload_current_scene()
	
	
	
