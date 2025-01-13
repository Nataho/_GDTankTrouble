extends Control

#region basic functions
func _ready() -> void:
	$"Save States/Save1".grab_focus(); getFocus()

func back():
	setButtonSignals()
	Transition.ChangeScene("modes","slideRight")

var pressingJoyButton
var currentFocus
func _process(delta: float) -> void:
	handleInput()

func handleInput():
	if Input.is_joy_button_pressed(0,JOY_BUTTON_DPAD_UP): getFocus()
	if Input.is_joy_button_pressed(0,JOY_BUTTON_DPAD_DOWN): getFocus()
	if Input.is_joy_button_pressed(0,JOY_BUTTON_DPAD_LEFT): getFocus()
	if Input.is_joy_button_pressed(0,JOY_BUTTON_DPAD_RIGHT): getFocus()
	
	if Input.is_joy_button_pressed(0,JOY_BUTTON_A):
		if pressingJoyButton: return
		pressingJoyButton = true
		if currentFocus is Button: currentFocus.emit_signal("pressed")
	else: pressingJoyButton = false
	#if Input.is_joy_button_pressed(0,JOY_BUTTON_GUIDE):
		#if pressingJoyButton: return
		#pressingJoyButton = true
		#if currentFocus is Button: currentFocus.emit_signal("pressed")

func getFocus():
	currentFocus = get_viewport().gui_get_focus_owner()
	return currentFocus
#endregion basic functions

#region buttons
func setButtonSignals():
	$"Save States/Save1".pressed.connect(save1)

func waitFocus():
	await Dbox.dialogue_finished
	$"Save States/Save1".grab_focus(); getFocus()

var Dbox:DBOX
func save1():
	AudioG.playSFX("button4",0) 
	Transition.ChangeScene("tropikala","slideDown")

	#release_focus()
	#StoryManager.startDialogue("Prologue","Start",self)
	#Dbox = StoryManager.getDbox()
	#waitFocus()
#endregion buttons

#region signals
#endregion signals
