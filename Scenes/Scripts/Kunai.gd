extends Area2D

const SCREEN_WIDITH = 64
const MOVE_SPEED = 128

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	position +=  Vector2(MOVE_SPEED * delta, 0.0)
	#if position.x >= SCREEN_WIDITH + 8:
	#	queue_free()



func _on_Kunai_body_entered(body):
	if body.is_in_group("enemy"):
		queue_free()
