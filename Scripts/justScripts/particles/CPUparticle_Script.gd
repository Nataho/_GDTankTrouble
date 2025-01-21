extends CPUParticles2D

func _ready() -> void:
	if !Debug.settings["graphics"]["show particles"]:
		hide()
