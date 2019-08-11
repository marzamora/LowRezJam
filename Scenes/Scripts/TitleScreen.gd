extends Control

onready var tween = get_node("tween")
var scene_path

func _ready():
	for button in $menu/main_options/buttons_container.get_children():
		button.connect("pressed", self, "on_button_pressed", [button.scene_to_load])

func on_button_pressed(scene_to_load):
	scene_path = scene_to_load
	#TODO: if play button is pressed then fade, if options_btn then dont play the fade animation
	if "Game" in scene_to_load:
		fade_music_out()
		$Fade_to_Black.show()
		$Fade_to_Black.fade()
	else:
		get_tree().change_scene(scene_to_load)

func _on_fade_to_black_fade_finished():
	get_tree().change_scene(scene_path)

func fade_music_out():
	tween.interpolate_property($music, 
	"volume_db", $music.get_volume_db(), -80, 1, 
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 0)
	tween.start()

func _on_tween_tween_completed(object, key):
	object.stop()
