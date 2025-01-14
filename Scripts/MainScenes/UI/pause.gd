extends CanvasLayer
class_name PAUSE

func _ready() -> void:
	get_tree().paused = true
	GameManager.isPaused = true
	$SidePanel/Selection/resume.grab_focus()

func unPause():
	get_tree().paused = false
	GameManager.isPaused = false
	
func resume():
	unPause()
	queue_free()

func restart():
	unPause()
	queue_free()
	Transition.ChangeScene("Tropikala","slideLeft")
	

func modeSelect():
	unPause()
	Transition.ChangeScene("modes","slideLeft")

func map():
	unPause()
	Transition.ChangeScene("campaign","slideLeft")

func quit():
	unPause()
	GameManager.quit()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		resume()
