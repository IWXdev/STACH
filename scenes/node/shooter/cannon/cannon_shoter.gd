extends CharacterBody2D

@onready var animation : AnimationPlayer = $AnimationPlayer
var health : float = 20
var dead : bool = false

func _on_start_animation_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		animation.play("ball fire")
		$CannonSound.play()


func _on_ball_damage_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.hit(10.0, Vector2(3, -1))


func _off_animation_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		animation.play("RESET")
		$CannonSound.stop()

func hit(damage : float , knockBack_dir : Vector2 ):
	health -= damage
	animation.play("hit")
	velocity = Vector2(knockBack_dir.x * 0 ,0)
	$Timer.start()
	if health <= 0:
		dead = true
		animation.play("dead")

func _on_timer_timeout() -> void:
	if dead:
		queue_free()
