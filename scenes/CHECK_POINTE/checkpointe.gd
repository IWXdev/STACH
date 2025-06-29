extends Area2D




func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$"../player".resp = global_position
		$"../player".health = PlayerData.health
