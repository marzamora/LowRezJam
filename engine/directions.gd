extends Node

const zero = Vector2.ZERO
const left = Vector2.LEFT
const right =  Vector2.RIGHT
const up = Vector2.UP
const down = Vector2.DOWN

func rand():
	var d = randi() % 5 + 1
	match d:
		1:
			return left
		2: 
			return right
		3:
			return up
		4:
			return down
		5: 
			return zero