extends Area2D

@onready var animationplayer : AnimationPlayer = $AnimationPlayer


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.hit(100, Vector2(3, -5))
		
