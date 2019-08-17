extends StaticBody2D

var is_door_open = false
var door_timer = 0
var door_timer_length = 120
var door_has_been_opened = false

func _ready():
	$area.connect("body_entered", self, "body_entered")

func _physics_process(delta):
	if door_timer > 0:
		door_timer -= 1
	if door_timer == 0 && door_has_been_opened:
		$anim_player.play("close")
		is_door_open = false

func body_entered(body):
	if body.is_in_group("player") && !is_door_open:
		$anim_player.play("open")
		is_door_open = true
	door_timer = door_timer_length