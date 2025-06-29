extends CharacterBody2D

@export var damage : int = 20
var direction : int = -1
var speed : float = 3000 
var health : float = 50
var stopRun : bool = false
@onready var healthbar : ProgressBar = $healthbar
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var dead : bool = false

func _ready() -> void:
	healthbar.value = health
	
	
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	if is_on_wall():
		direction *= -1
		$AnimatedSprite2D.scale.x = direction * -1
	if !stopRun:
		velocity.x = direction * speed * delta
	
	move_and_slide()

func hit(damage : float , knockBack_dir : Vector2 ):
	health -= damage
	healthbar.value = health
	stopRun = true
	sprite.play("hit")
	velocity = Vector2(knockBack_dir.x * 100 , -100)
	$Timer.start()
	if health <= 0:
		dead = true
		sprite.play("dead")

func _on_timer_timeout() -> void:
	stopRun = false
	if dead:
		queue_free()



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.hit(20.0, Vector2(3, -1))


func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite.animation == ("hit"):
		sprite.play("Run")
