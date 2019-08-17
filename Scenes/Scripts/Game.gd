extends Node2D

onready var player = get_node("Player")
onready var UI = get_node("HUD/UserInterface")



func _ready():
	player.connect("health_updated", UI, "_on_health_updated")
	set_process(false)

func _process(delta):
	if Input.is_key_pressed(KEY_SPACE):
		get_tree().change_scene("res://Scenes/Game.tscn")

func _on_Player_killed():
	$HUD/UserInterface.hide()
	$"HUD/Game Over".show()
	set_process(true)


func _on_Boss_boss_killed():
	$HUD/Win.show()
