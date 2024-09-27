extends Node2D

func _input(event):
	if event.is_action_pressed("reset"):
		reset()
	if event.is_action_pressed("RemoteMissile"):
		PlayerG.playerPower = !PlayerG.playerPower
func reset():
	get_tree().reload_current_scene()
