extends ColorRect

signal fade_finished

func fade():
	$fade_anim.play("fade")

func _on_fade_anim_animation_finished(anim_name):
	emit_signal("fade_finished")
