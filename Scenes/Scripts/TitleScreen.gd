extends Control

var scene_path

func _ready():
	for button in $menu/main_options/buttons_container.get_children():
		button.connect("pressed", self, "on_button_pressed", [button.scene_to_load])

func on_button_pressed(scene_to_load):
	scene_path = scene_to_load
	#TODO: if play button is pressed then fade, if options_btn then dont play the fade animation
	$Fade_to_Black.show()
	$Fade_to_Black.fade()

func _on_fade_to_black_fade_finished():
	get_tree().change_scene(scene_path)
