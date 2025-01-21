extends CanvasLayer
class_name OPTIONS

signal removed

@onready var general: Button = $SidePanel/Selection/general
@onready var anim: AnimationPlayer = $Anim

@export var hasPanelParent = false
const transparent = Color(1,1,1,0) 

var exiting = false

func _ready() -> void:
	general.grab_focus()
	if hasPanelParent: 
		_hidePanel()
	anim.play("enter")
	
func _hidePanel():
	$ScreenBlur.hide()
	$ScreenPanel.hide()
	$SidePanel.color = transparent

#region handle button press
func _back():
	exiting = true
	removed.emit()
	anim.play("exit")
	await anim.animation_finished
	queue_free()
#endregion handle button press

#region options: Graphics
@onready var button_fps: CUSTOM_BUTTON1 = $Content/Graphics/ShowFPS

var showingFPS = Debug.isFPSActive

func graphicsFocused():
	$Content/Graphics.show()
	
	if !showingFPS: button_fps.text_label.text = "Show FPS:\nOFF"
	
func graphicsUnFocused():
	if exiting: await anim.animation_finished
	$Content/Graphics.hide()
func graphicsPressed():
	button_fps.grab_focus()

func showFPS():
	showingFPS = !showingFPS
	if showingFPS: 
		button_fps.text_label.text = "Show FPS:\nON"
	else: 
		button_fps.text_label.text = "Show FPS:\nOFF"
	Debug.runFPS(showingFPS)
		#print("showingFPS: ", showingFPS )
#endregion options: Graphics

func _input(event: InputEvent) -> void:
	if event.is_action_released("pause"):
		_back()
