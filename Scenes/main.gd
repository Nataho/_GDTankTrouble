extends Node2D

func _ready():
	loadParticles()
	GameManager.LoadGame()
	GameManager.isIdle = false
	if GameManager.Debug: $Unattended.wait_time = 5
	PlayerG.reset()
	AudioG.playMusic("main menu")
	
	$CanvasLayer/Control/Play.grab_focus()

var pressingJoyButton = false
var currentFocus
func _process(delta: float) -> void:
	currentFocus = get_viewport().gui_get_focus_owner()
	if Input.is_joy_button_pressed(0,0):
		if not pressingJoyButton:
			pressingJoyButton = true
			if currentFocus is Button: currentFocus.emit_signal("pressed")
	else: pressingJoyButton = false

var isMenuButtonPresssing = false
#func _process(delta: float) -> void:
	#if Input.is_joy_button_pressed(0,11):
		#if not isMenuButtonPresssing:
			#isMenuButtonPresssing = true
			#print("pressing A")

func loadParticles():
	$Particles/Particle1.show()
	$Particles/Particle2.show()
	$Particles/Particle3.show()
	$Particles/Particle4.show()
	
func buttonPlay():
	AudioG.playSFX("button1",0)
	Transition.ChangeScene("modes","slideRight")

func buttonTutorial():
	Transition.ChangeScene("tutorial","dissolve")

func debug():
	get_tree().change_scene_to_file("res://Scenes/MainScenes/player_menu.tscn")

func _input(event):
	if event is InputEventMouseMotion:
		var mouse_movement = event.relative
		$Unattended.start()

func Unattended():
	GameManager.isIdle = true
	PlayerG.FFA_TimeLimit = 20
	var maxPlayers = 7
	var loopIndex = 0
	while loopIndex <= maxPlayers:
		PlayerG.ActivePlayers.append(loopIndex)
		PlayerG.activeTankColor[loopIndex] = PlayerG.tankColor[loopIndex]
		PlayerG.isAI[loopIndex] = true
		#PlayerG.playerNames[loopIndex] = "Player " + str(loopIndex+1)
		PlayerG.playerNames[loopIndex] = ""
		
		loopIndex += 1
	Transition.ChangeScene("loading","dissolve")
