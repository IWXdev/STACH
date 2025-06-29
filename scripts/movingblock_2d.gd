extends CharacterBody2D

@export var path_follow : PathFollow2D
@export var speed : float = 70

var last_position: Vector2
var player : Node = null

func _ready():
	last_position = global_position

func _physics_process(delta):
	path_follow.progress += speed * delta
	
	var movement = global_position - last_position
	last_position = global_position
	if player:
		player.global_position += movement


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		player = body


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == player:
		player = null
