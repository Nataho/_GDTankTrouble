extends Control

@onready var buttons = [
	$CampaignMode,
	$Multiplayer,
	$Tutorial,
]

func _ready() -> void:
	connectAllSignals()
	#activeAnimations()
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
	
	var joystickName = Input.get_joy_name(0)
	buttons[selectIndex.x].grab_focus()
	currentFocus = get_viewport().gui_get_focus_owner()
	print(joystickName)
	print("joystickNamewasdf")

func back():
	Transition.ChangeScene("main","dissolve")
#region button select
var selectIndex:Vector2i = Vector2i(0,0)
var maxIndex:Vector2i = Vector2i(0,2)
var deadZone = 0.3
var DAS = 0.5 #DELAY AUTO SHIFT
var pressingDir:Vector2 = Vector2(false,false)
var pressingJoyButton:bool = false
var currentFocus:Button

func _process(delta: float) -> void:
	handleInput()
	handleAnimations(delta)

func handleInput():
	var direction:Vector2i = Vector2i(0,0)
	if Input.is_joy_button_pressed(0,11):
		if not pressingDir.y:
			pressingDir.y = true
			direction.y = -1
			select(direction)
			#print("pressing up")
	elif Input.is_joy_button_pressed(0,12):
		if not pressingDir.y:
			pressingDir.y = true
			direction.y = 1
			select(direction)
			#print("pressing down")
	else: 
		pressingDir.y = false
		direction.y = 0
	
	if Input.is_joy_button_pressed(0,JOY_BUTTON_A): #A
		if not pressingJoyButton:
			pressingJoyButton = true
			if currentFocus is Button: currentFocus.emit_signal("pressed")
	else: pressingJoyButton = false
	if Input.is_joy_button_pressed(0,JOY_BUTTON_B): #B
		if not pressingJoyButton:
			pressingJoyButton = true
			back()
	else: pressingJoyButton = false

func select(input:Vector2):
	if input.x > deadZone: selectIndex.x += 1
	elif input.x < -deadZone: selectIndex.x -= 1
		
	if input.y > deadZone: selectIndex.y += 1
	if input.y < -deadZone: selectIndex.y -= 1
	currentFocus = get_viewport().gui_get_focus_owner()
	#print(selectIndex)
#endregion button select

#region buttons
func connectAllSignals():
	$CampaignMode.focus_entered.connect(CampaginModeFocused)
	$Multiplayer.focus_entered.connect(MultiplayerFocused)
	$Tutorial.focus_entered.connect(TutorialFocused)

func CampaignMode():
	AudioG.playSFX("button2",0)
	Transition.ChangeScene("campaign menu","slideLeft")
	print("Entering Campaign Mode")
func CampaginModeFocused(): 
	currentAnim = CAMPAIGN
	#animate.play("CampaignIn")
	#CampIn()
func CampaignModeUnFocused(): pass


func Multiplayer():
	AudioG.playSFX("button2",0)
	Transition.ChangeScene("player menu", "slideLeft")
	print("Entering Multiplayer")
func MultiplayerFocused():
	currentAnim = MULTI

func Tutorial():
	AudioG.playSFX("button2",0)
	Transition.ChangeScene("tutorial", "slideRight")
	print("Entering Tutorial")
func TutorialFocused():
	currentAnim = TUTS
#endregion buttons

#region animation
@onready var animate: AnimationPlayer = $"Animate"
@onready var animTree: AnimationTree = $"AnimationTree"

#@onready var animState = animTree.get("parameters/playback")

func activeAnimations():
	animTree.active = true

#func CampIn():
	#animState.travel("CampaignIn")
#func CampOut():
	#animState.travel("CampaignOut")
#func blendAnims(blendValue):
	#animTree["parameters/Campaign/blend_amount"] = blendValue
	##animTree.set("parameters/Campaign/blend_position", blendValue)
enum {CAMPAIGN,MULTI,TUTS}
var currentAnim = MULTI

var CampaignAmount = -1 #campaign
var MultiAmount = -1 #Multiplayer
var TutsAmount = -1 #Tutorial
#var cout = 0 #campaign out

func handleAnimations(delta):
	match currentAnim:
		CAMPAIGN:
			#animTree.set("parameters/Transition/transition_request", "CAMPIN")
			CampaignAmount = lerpf(CampaignAmount,1,5*delta)
			MultiAmount = lerpf(MultiAmount,-1,5*delta)
			TutsAmount = lerpf(TutsAmount,-1,5*delta)
			#animTree.set("parameters/Campaign/blend_position", CampaignAmount)
		MULTI:
			#animTree.set("parameters/Transition/transition_request", "CAMPOUT")
			CampaignAmount = lerpf(CampaignAmount,-1,5*delta)
			MultiAmount = lerpf(MultiAmount,1,5*delta)
			TutsAmount = lerpf(TutsAmount,-1,5*delta)
		TUTS:
			CampaignAmount = lerpf(CampaignAmount,-1,5*delta)
			MultiAmount = lerpf(MultiAmount,-1,5*delta)
			TutsAmount = lerpf(TutsAmount,1,5*delta)
			
	animTree.set("parameters/Campaign/blend_position", CampaignAmount)
	animTree.set("parameters/Multi/blend_position", MultiAmount)
	animTree.set("parameters/Tutorial/blend_position", TutsAmount)
	

#func update_tree():
	#animTree["parameters/Campaign/blend_amount"] = CampaignAmount
	#animTree["parameters/Campaign/blend_amount"] = CampaignAmount
#endregion animation
