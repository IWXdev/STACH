extends Node2D

@onready var animation : AnimatedSprite2D = $AnimHP
@onready var anima : AnimatedSprite2D = $AnimationPlayer

func _ready() -> void:
	animation.play("hp")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$HealthSound.play()
		animation.play("cion_effect")
		body.HP_anim()
		body._HP(20)
		$Timer.start()
func _on_queue_free_timeout() -> void:
	queue_free()
