extends Node2D

onready var player = get_node("Player")
onready var UI = get_node("HUD/UserInterface")

func _ready():
	player.connect("health_updated", UI, "_on_health_updated")
	