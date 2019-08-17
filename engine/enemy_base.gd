extends KinematicBody2D

export var speed = 24

var movetimer_length = 30
var movetimer = 0
var velocity = Vector2(0,0)
var move_direction = Vector2(0,0)

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