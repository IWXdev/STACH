extends CharacterBody2D

@export var SPEED : float = 200.0
@export var JUMP_VELOCITY : float = -220.0
@export var damage : float = 10
@export var health : float = 100
@export var HP : float = 60


@onready var animationplayer: AnimationPlayer = $AnimationPlayer
#@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var attacktimer : Timer = $attackTimer
@onready var sword : Area2D = $Marker2D/sword
@onready var healthbar : ProgressBar = $Camera2D/healthbar


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : float
var land : bool = false
var max_health = 100
var double_jump : bool
var attacking : bool = false
var jumpAttack : bool = false
var attackNum : int = 0
var hitting : bool = false
var Dead : bool  = false
var resp = Vector2(21 ,-15)
var veloctiy = Vector2.ZERO
var anim_work = false

func _ready() -> void:
	health = PlayerData.health
	max_health = PlayerData.max_health
	healthbar.value = health

	
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		land = true
	else :
		double_jump = false
		
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("Exit"):
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	
	if !hitting || !Dead:
		move(delta)
		jump()
		if is_on_floor():
			attack()
		else:
			air_attack()
		animation()
	move_and_slide() 
	
func air_attack():
	if not is_on_floor() && Input.is_action_just_pressed("jumpAttack"):
		jumpAttack = true
	
func attack():
	if Input.is_action_pressed("attack") && !attacking:
		if attackNum == 3:
			attackNum = 0
		attacking = true
		$Node2D/AttackSound.play()
		attacktimer.start()
		attackNum += 1
func move(delta):
	direction = Input.get_axis("left", "right")
	if direction:
		$Marker2D.scale.x = direction
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func jump():
	if Input.is_action_just_pressed("jump"):
		if attacking:
			attackNum = 0
			attacking = false
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			$Node2D/JumpSound.play()
		elif not double_jump:
			velocity.y = JUMP_VELOCITY
			$Node2D/JumpSound.play()
			double_jump = true

func animation():
	if Dead:
		animationplayer.play("Dead")
		return
	if hitting:
		animationplayer.play("hit")
		return
	if anim_work:
		animationplayer.play("potion_hp")
	elif not is_on_floor():
		if velocity.y < 0:
			animationplayer.play("jumpstart")
		elif jumpAttack:
			animationplayer.play("Attack_J")
		else :
			animationplayer.play("jumpfall")
	elif land and is_on_floor():
		animationplayer.play("jumpend")
	elif attacking:
		if attackNum == 1 :
			animationplayer.play("Attack1")
		elif attackNum == 2 :
			animationplayer.play("Attack2")
		elif attackNum == 3 :
			animationplayer.play("Attack3")
	elif direction != 0:
		animationplayer.play("Run")
	elif direction == 0:
		animationplayer.play("Idle")

func hit(damageEnimy : float, knockBack_dir : Vector2):
	health -= damageEnimy
	healthbar.value = health
	hitting = true
	velocity = Vector2(knockBack_dir.x * 100 , -100)
	$Timer.start()
	if health <= 0:
		Dead = true
		$Node2D/DeadSound.play()
		$Timer.start()
		set_collision_layer_value(1, false)

func _HP(amount):
	health = clamp(health + amount, 0, max_health)
	PlayerData.health = health
	PlayerData.max_health = max_health
	healthbar.value = health

func _on_attack_timer_timeout() -> void:
	attackNum = 0



func _on_sowrd_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		var knockBack_dir : Vector2
		var damageDir = body.global_position - global_position
		var dirsign = sign(damageDir.x)
		if dirsign > 0:
			knockBack_dir = Vector2.RIGHT
		elif dirsign < 0:
			knockBack_dir = Vector2.LEFT
		else:
			knockBack_dir = Vector2.ZERO
		
		body.hit(damage , knockBack_dir)


func _on_timer_timeout() -> void:
	hitting = false
	if !Dead:
		Dead = false


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "jumpend":
		land = false
	if anim_name == "Attack1" || anim_name == "Attack2" || anim_name == "Attack3" :
		attacking = false
	if anim_name == "Attack_J":
		jumpAttack = false
	if anim_name == "potion_hp":
		anim_work = false
	if anim_name == "Dead":
		health = PlayerData.health
		healthbar.value = health
		global_position = resp
		Dead = false
		set_collision_layer_value(1,true)

func HP_anim():
	anim_work = true
