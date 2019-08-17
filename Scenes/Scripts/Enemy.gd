extends KinematicBody2D

signal health_updated(health)
signal max_health_updated(max_health)
signal killed()

export var speed = 24
export (float) var max_health = 100 

onready var UI = $EnemyHealthBar
onready var health = max_health setget _set_health

var movetimer_length = 30
var movetimer = 0
var state_machine
var velocity = Vector2(0,0)
var move_direction = Vector2(0,0)

func _ready():
	state_machine = $anim_tree.get("parameters/playback")
	move_direction = dir.rand()
	$area.connect("area_entered", self, "_area_entered")
	connect("health_updated", UI, "_on_health_updated") 

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity, Vector2(0,0))
	
	if velocity != Vector2(0,0):
		anim_switch("run")
	else:
		anim_switch("idle")

	if movetimer > 0:
		movetimer -= 1
	if movetimer == 0:
		move_direction = dir.rand()
		movetimer = movetimer_length

func get_input():
	velocity = Vector2(0,0)
	if move_direction == dir.up:
		velocity.y -= 1
	if move_direction == dir.down:
		velocity.y += 1
	if move_direction == dir.left:
		velocity.x -= 1
		$sprite.scale.x = -1
	if move_direction == dir.right:
		velocity.x += 1
		$sprite.scale.x = 1
	if move_direction == dir.zero:
		velocity = dir.zero
	velocity = velocity.normalized() * speed

func anim_switch(animation):
	var current_anim_state = state_machine.get_current_node()
	var new_anim = str(animation)
	if new_anim != current_anim_state:
		state_machine.travel(new_anim)

func damage(amount):
	# consider adding invulnerabilty_timer after taking damage, one shot timer
	# New logic would be if dash_timer.is_stopped or i_timer.is_stopped:
	# start timer when damage taken
	_set_health(health - amount)

func deaded():
	queue_free()

func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)
	if health != prev_health:
		emit_signal("health_updated", health)
		if health == 0:
			deaded()
			emit_signal("killed")

func _area_entered(area):
	if area.is_in_group("player_weapon"):
		damage(2)







