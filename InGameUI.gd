extends Control
func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")


func _on_audio_stream_player_2d_finished():
	$GameMusic.play(0.0)


func _on_left_2_pressed():
	Input.action_press("rotate left")
func _on_left_2_released():
	Input.action_release("rotate left")
	
func _on_right_touch_pressed():
	Input.action_press("rotate right")
func _on_right_touch_released():
	Input.action_release("rotate right")

func _on_jump_pressed():
	Input.action_press("forward")
func _on_jump_released():
	Input.action_release("forward")
	
func backward_pressed():
	Input.action_press("back")
func backward_released():
	Input.action_release("back")

func shoot_pressend():
	Input.action_press("shoot")
func shoot_released():
	Input.action_release("shoot")
