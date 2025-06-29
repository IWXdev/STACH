extends CharacterBody2D

@onready var animation : AnimationPlayer = $AnimationPlayer
var DialogueIsactive : bool
var agoo : bool = false
func _process(delta: float) -> void:
	if agoo && (Input.is_action_just_pressed("dialogue") && !DialogueIsactive):
		DialogueIsactive = true
		DialogueManager.show_example_dialogue_balloon(load("res://assest/dialogue/scene_1dialogue.dialogue"),"solo7of")
	if agoo && (Input.is_action_just_pressed("shop")):
		#get_tree().paused = true
		get_node("shop/Anim").play("Inlod")
	
	
func _on_zoon_seller_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		animation.play("idel_on_area")
		agoo = true

func _ready() -> void:
	DialogueIsactive = false
	DialogueManager.dialogue_ended.connect(on_ended_dialog)
	pass
	

func on_ended_dialog(_resource : DialogueResource):
	DialogueIsactive = false
	pass


func _on_area_2d_body_exited(body: Node2D) -> void:
	animation.play("idel")
	agoo = false
