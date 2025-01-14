extends CanvasLayer
class_name PAUSE

func _ready() -> void:
	#Engine.time_scale = 0
	get_tree().paused = true
	GameManager.isPaused = true
	$SidePanel/Selection/resume.grab_focus()

func resume():
	#Engine.time_scale = 1
	get_tree().paused = false
	GameManager.isPaused = false
	queue_free()

func modeSelect():
	get_tree().paused = false
	Transition.ChangeScene("modes","slideLeft")

func map():
	get_tree().paused = false
	Transition.ChangeScene("campaign","slideLeft")
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		resume()
