extends KinematicBody2D

export var speed = 32
var velocity = Vector2(0,0)

func get_input():
	velocity = Vector2(0,0)
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("right"):
		velocity.x += 1
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)