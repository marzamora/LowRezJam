extends Area2D

const MOVE_SPEED = 128

var dir_x = 0.0
var dir_y = 0.0
var pos_vector = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	position +=  Vector2(dir_x * delta, dir_y * delta)
	#if position.x >= SCREEN_WIDITH + 8:
	#	queue_free()

func travel_direction(direction):
	match direction:
		"_left":
			dir_x = -MOVE_SPEED
			dir_y = 0.0
			$sprite.scale.x = -1
			pos_vector = Vector2(-10, 0)
		"_right":
			dir_x = MOVE_SPEED
			dir_y = 0.0
			$sprite.scale.x = 1
			pos_vector = Vector2(10, 0)
		"_down":
			dir_x = 0.0
			dir_y = MOVE_SPEED
			$sprite.rotation_degrees = 90
			pos_vector = Vector2(0, 10)
		"_up":
			dir_x = 0.0
			dir_y = -MOVE_SPEED
			$sprite.rotation_degrees = -90
			pos_vector = Vector2(0, -10)

func _on_Kunai_body_entered(body):
	if body.is_in_group("enemy"):
		queue_free()
