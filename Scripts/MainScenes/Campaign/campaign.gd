extends Control

var saveIndex = StoryManager.usedSaveIndex

func _ready() -> void:
	AudioG.playMusic("ambience 01",5)
	%Prologue.grab_focus()
	checkCompletion()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("goBack"): 
		Transition.ChangeScene("main","slideLeft")

func checkCompletion():
	var objectives = StoryManager.objectives
	if objectives[saveIndex]["Prologue Complete"]: $GridContainer/Tropikala.disabled = false
	if objectives[saveIndex]["Tropikala Complete"]: $GridContainer/AtsuIsland.disabled = false
	if objectives[saveIndex]["Atsu Island Complete"]: $GridContainer/Domageti.disabled = false
	if objectives[saveIndex]["Domageti Complete"]: $GridContainer/Scharbi.disabled = false

var pressedButton = {
	"up": false,
	"down": false,
	"left": false,
	"right": false,
}
var buttonUp = preload("res://Assets/Photos/Joystick.png")
var buttonDown = preload("res://Assets/Photos/Pressed_Joystick.png")
func _process(delta: float) -> void:
	buttonInput()
	
func buttonInput():
	if Input.is_joy_button_pressed(0,JOY_BUTTON_DPAD_UP):
		if !pressedButton["up"]:
			$up.texture_normal = buttonDown
			pressedButton["up"] = true
	else:
		$up.texture_normal = buttonUp
		pressedButton["up"] = false
		
	if Input.is_joy_button_pressed(0,JOY_BUTTON_DPAD_DOWN):
		if !pressedButton["up"]:
			$down.texture_normal = buttonDown
			pressedButton["up"] = true
	else:
		$down.texture_normal = buttonUp
		pressedButton["up"] = false
	
	if Input.is_joy_button_pressed(0,JOY_BUTTON_DPAD_LEFT):
		if !pressedButton["up"]:
			$left.texture_normal = buttonDown
			pressedButton["up"] = true
	else:
		$left.texture_normal = buttonUp
		pressedButton["up"] = false
	
	if Input.is_joy_button_pressed(0,JOY_BUTTON_DPAD_RIGHT):
		if !pressedButton["up"]:
			$right.texture_normal = buttonDown
			pressedButton["up"] = true
	else:
		$right.texture_normal = buttonUp
		pressedButton["up"] = false

#region startMaps
func Prologue():
	AudioG.playSFX("button4",0)
	StoryManager.currentMap = "Prologue"
	Transition.ChangeScene("tropikala","slideLeft")

func Tropikala():
	AudioG.playSFX("button4",0)
	StoryManager.currentMap = "Tropikala"
	Transition.ChangeScene("tropikala","slideLeft")
#endregion startMaps
