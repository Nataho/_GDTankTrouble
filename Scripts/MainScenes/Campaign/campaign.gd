extends Control

@onready var buttons = [

]

func _ready() -> void:
	%Prologue.grab_focus()

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
