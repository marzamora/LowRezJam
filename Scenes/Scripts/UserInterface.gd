extends Control

onready var health_bar = $bars/health_bar

func _ready():
	var player_max_health = $"../../Player".max_health
	health_bar.max_value = player_max_health
	health_bar.value = player_max_health

func _on_health_updated(health):
	health_bar.value = health

func _on_max_health_updated(max_health):
	health_bar.max_value = max_health