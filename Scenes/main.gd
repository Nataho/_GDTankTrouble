extends Node2D

func _ready():
	GameManager.isIdle = false
	if GameManager.Debug: $Unattended.wait_time = 5
	
	$Particles/Particle1.show()
	$Particles/Particle2.show()
	$Particles/Particle3.show()
	$Particles/Particle4.show()
	
	PlayerG.reset()
	AudioG.playMusic("main menu")

func buttonPlay():
	AudioG.playSFX("button press",0)
	Transition.ChangeScene("player menu","slideRight")

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
		PlayerG.playerNames[loopIndex] = "Player " + str(loopIndex+1)
		
		loopIndex += 1
	Transition.ChangeScene("loading","dissolve")
