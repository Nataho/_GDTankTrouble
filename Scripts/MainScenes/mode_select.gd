extends Control

@onready var buttons = [
	$CampaignMode,
	$Multiplayer,
	$Tutorial,
]

func _ready() -> void:
	var joystickName = Input.get_joy_name(0)
	buttons[selectIndex.x].grab_focus()
	print(joystickName)
	print("joystickNamewasdf")

#region button select
var selectIndex:Vector2i = Vector2i(0,0)
var maxIndex:Vector2i = Vector2i(0,2)
var deadZone = 0.3
var DAS = 0.5 #DELAY AUTO SHIFT
var pressing:Vector2 = Vector2(false,false)

func _process(delta: float) -> void:
	if Input.is_joy_button_pressed(0,11):
		if not pressing.y:
			pressing.y = true
			print("pressing up")
	elif Input.is_joy_button_pressed(0,12):
		if not pressing.y:
			pressing.y = true
			print("pressing down")
	else: pressing.y = false

func select(input:Vector2):
	if input.x > deadZone: selectIndex.x += 1
	elif input.x < -deadZone: selectIndex.x -= 1
		
	if input.y > deadZone: selectIndex.y += 1
	if input.y < -deadZone: selectIndex.y -= 1
#endregion button select
