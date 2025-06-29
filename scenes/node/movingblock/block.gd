extends CharacterBody2D

@export var speed : float = 20000

@onready var animation : AnimationPlayer = $AnimationPlayer

var gravty = ProjectSettings.get_setting("physics/2d/default_gravity")
var fall : bool = false
var fall2 : bool = false

var last_position: Vector2
var player : Node = null

func _ready() -> void:
	last_position = global_position



func _physics_process(delta: float) -> void:
	if fall :
		velocity.y = speed * delta
	elif fall:
		velocity.y = gravty * delta
	
	var movement = global_position - last_position
	last_position = global_position
	if player:
		player.global_position += movement
	
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		animation.play("vibra_block")
		$Timer.start()
	
	if body.name == "player":
		player = body

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "vibra_block":
		fall = true


func _on_timer_timeout() -> void:
	fall = false
	fall2 = false
	position.y = 0
	velocity.y = 0


func _on_area_2d_body_exited(body: Node2D) -> void:
	fall2 = true 
	if body == player:
		player = null
	
