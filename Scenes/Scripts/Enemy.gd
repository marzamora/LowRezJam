extends "res://engine/enemy_base.gd"

signal health_updated(health)
signal max_health_updated(max_health)
signal boss_killed()

export (float) var max_health = 200 

onready var UI = $EnemyHealthBar
onready var health = max_health setget _set_health

var state_machine

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
			emit_signal("boss_killed")

func _area_entered(area):
	if area.is_in_group("player_weapon"):
		damage(3)
	if area.is_in_group("player_projectile"):
		damage(2)







