extends CanvasLayer

func _ready() -> void:
	$Animate.play("programees")
	await $Animate.animation_finished
	$Control/Godot.show()
	await get_tree().create_timer(2).timeout
	Transition.ChangeScene("main", "dissolve")
