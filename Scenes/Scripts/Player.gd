extends KinematicBody2D

signal health_updated(health)
signal max_health_updated(max_health)
signal killed()

export var dash_speed = 150
export var speed = 32
export (float) var max_health = 20 

onready var dash_timer = get_node("dash_timer")
onready var health = max_health setget _set_health

var state_machine
var velocity = Vector2(0,0)
var is_dashing = false
var sprite_dir = "right"

func _ready():
	state_machine = $anim_tree.get("parameters/playback")

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity, Vector2(0,0))
	set_sprite_dir()
	
	print(sprite_dir)
	
#	if velocity != Vector2(0,0):
#		anim_switch("run")
#	else:
#		anim_switch("idle")

func get_input():
	velocity = Vector2(0,0)
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
		$sprite.scale.x = -1
	if Input.is_action_pressed("right"):
		velocity.x += 1
		$sprite.scale.x = 1
	if Input.is_action_just_pressed("dash"):
		dash_timer.start()
		is_dashing = true
	if !is_dashing:
		velocity = velocity.normalized() * speed
	if is_dashing:
		velocity = velocity.normalized() * dash_speed

func set_sprite_dir():
	match velocity:
		Vector2(-1,0):
			sprite_dir = "_left"
		Vector2(1,0):
			sprite_dir = "_right"
		Vector2(0, -1):
			sprite_dir = "_up"
		Vector2(0, 1):
			sprite_dir = "_down"

func anim_switch(animation):
	var current_anim_state = state_machine.get_current_node()
	var new_anim = str(animation, sprite_dir)
	if new_anim != current_anim_state:
		state_machine.travel(new_anim)

func _on_dash_timer_timeout():
	is_dashing = false

func damage(amount):
	# consider adding invulnerabilty_timer after taking damage, one shot timer
	# New logic would be if dash_timer.is_stopped or i_timer.is_stopped:
	# start timer when damage taken
	if dash_timer.is_stopped():
		_set_health(health - amount)

func deaded():
	pass

func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)
	if health != prev_health:
		emit_signal("health_updated", health)
		if health == 0:
			deaded()
			emit_signal("killed")
