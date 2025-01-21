extends CanvasLayer
class_name PAUSE

@onready var anim: AnimationPlayer = $Anim
var _otherMenuActive:bool = false

func _ready() -> void:
	anim.play("enter")
	get_tree().paused = true
	GameManager.isPaused = true
	$SidePanel/Selection/resume.grab_focus()


func unPause():
	get_tree().paused = false
	GameManager.isPaused = false
	
func resume():
	if get_parent() == get_tree().get_root(): return
	
	unPause()
	queue_free()
	if get_parent().pauseMenu != null:
		get_parent().pauseMenu = null

func restart():
	unPause()
	queue_free()
	Transition.ChangeScene("tropikala","slideLeft")
	
func options():
	anim.play("new_menu")
	var optionsScene = load("res://Scenes/MainScenes/UI/options.tscn")
	var optionsNode:OPTIONS = optionsScene.instantiate()
	
	optionsNode.hasPanelParent = true
	add_child(optionsNode)
	_otherMenuActive = true
	
	await optionsNode.removed
	anim.play("new_menu_enter")
	_otherMenuActive = false
	$SidePanel/Selection/resume.grab_focus()

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
		if _otherMenuActive: return
		resume()
