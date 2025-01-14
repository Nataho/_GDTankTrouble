extends Control

var completedChapters = [
		0,
		0,
		0,
	]
#region basic functions
func _ready() -> void:
	GameManager.LoadGame()
	print(StoryManager.objectives[0])
	checkSaveStates()
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
	#
	#if Input.is_joy_button_pressed(0,JOY_BUTTON_A):
		#if pressingJoyButton: return
		#pressingJoyButton = true
		#if currentFocus is Button: currentFocus.emit_signal("pressed")
	#else: pressingJoyButton = false
	#if Input.is_joy_button_pressed(0,JOY_BUTTON_GUIDE):
		#if pressingJoyButton: return
		#pressingJoyButton = true
		#if currentFocus is Button: currentFocus.emit_signal("pressed")

func getFocus():
	currentFocus = get_viewport().gui_get_focus_owner()
	return currentFocus

func checkSaveStates():
	#if !StoryManager.objectives[0]["Prologue Complete"]: $"Save States/Save1/Chapters".hide()
	var index = 0
	
	while index < 3:
		var text = [
				$"Save States/Save1/Chapters",
				$"Save States/Save2/Chapters",
				$"Save States/Save3/Chapters"
			]
		for objective in StoryManager.objectives[index].keys():
			
			if StoryManager.objectives[index][objective] == true: completedChapters[index] += 1
			print(StoryManager.objectives[index][objective])
			
			text[index].text = "Chapters: " + str(completedChapters[index])
		if completedChapters[index] <= 0: text[index].hide()
		index += 1
	#var objectives = StoryManager.objectives[index]
	#print(objectives["Prologue Complete"])
	#for objectives in StoryManager.objectives[index].keys():
		#print(StoryManager.objectives[index][objectives])
		#pass
	
#endregion basic functions

#region buttons
func setButtonSignals():
	$"Save States/Save1".pressed.connect(save1)

func waitFocus():
	await Dbox.dialogue_finished
	$"Save States/Save1".grab_focus(); getFocus()

var Dbox:DBOX
func save1():
	if completedChapters[0] <= 0: AudioG.playSFX("button4",0) 
	elif completedChapters[0] > 0: AudioG.playSFX("button3",0) 
	
	
	if StoryManager.objectives[0]["Prologue Complete"]:
		Transition.ChangeScene("campaign","slideDown")
		return
	Transition.ChangeScene("tropikala","slideDown")
	StoryManager.currentMap = "Prologue"
	
	#release_focus()
	#StoryManager.startDialogue("Prologue","Start",self)
	#Dbox = StoryManager.getDbox()
	#waitFocus()
#endregion buttons

#region signals
#endregion signals
