extends Node2D

@onready var TIME: Label = $UI/TIME



const PLAYER = preload("res://Scenes/Prefabs/player.tscn")

#will contain all of the player tags or player names
var playerTagArray = [] 
var playerNodeArray = []
var ActivePlayers = PlayerG.ActivePlayers

#@export_range(0,8,0.1) 
var Players:int =  0
#@export 
var EnableKeyboard: bool = false

#region Important Stuff
func _ready() -> void:
	
	if PlayerG.isSurvival: 
		var realPlayers:int = 0
		for indexes in PlayerG.isAI.keys():
			if !PlayerG.isAI[indexes]: realPlayers += 1
			
		if realPlayers > 1: lives = 99
		$UI/TIME.text = "Lives: " + str(lives)
		
	leaderboards()
		
	if PlayerG.FFA_TimeLimit == 0 or PlayerG.isSurvival:
		$Countdown.stop()

	if OS.get_name() == "Android":
		Android()
	print(PlayerG.isAI)
	ActivePlayers = PlayerG.ActivePlayers
	#Players = PlayerG.playerAmount #########NOT A PART OF THE SNIPPET
	Players = PlayerG.ActivePlayers.size()
	EnableKeyboard = PlayerG.EnableKeyboard
	
	if !GameManager.isIdle: AudioG.playMusic("FFA 1")
	#if !PlayerG.isSurvival: AudioG.playMusic()
	else: AudioG.playMusic("square roll")
	SpawnPlayers()
	
	if GameManager.isIdle: idle()
	
	#region testing
	print("entering players: ", PlayerG.ActivePlayers)
	print(Players)
	#endregion

func Android():
	var mobileUI = load("res://InGameUI.tscn")
	var mobileUI_Instance = mobileUI.instantiate()
	add_child(mobileUI_Instance)

var defaultModulate = 1
var allModulate = defaultModulate
var camZoom = 1
var isZooming = false
func _process(delta: float) -> void:
	if cam != null: cam.translate(Vector2(1,0))
	
	TagsFollowPlayer()
	#if isZooming && camZoom < 5:
		#spawnCam.position = playerNodeArray[1].position
		#camZoom += 0.001
		#if camZoom > 5: camZoom == 5
	#else:
		#spawnCam.position = Vector2(2560/2,1440/2)
		#camZoom -= 0.001
		#if camZoom < 1: camZoom == 1
	#spawnCam.zoom = Vector2(camZoom,camZoom)
	
	while allModulate < defaultModulate:
		modulate = Color(1,allModulate,allModulate)
		$Barriers/Walls.modulate = Color(5, 5*allModulate, 5*allModulate)
		allModulate += 0.0001
		await get_tree().create_timer(0.5).timeout
		if allModulate > defaultModulate: allModulate = defaultModulate
	
	
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion && GameManager.isIdle:
		GameManager.isIdle = false
		Transition.ChangeScene("main","slideLeft")
	#if event.is_action_pressed("shoot"):
		#Transition.ChangeScene("main", "slideLeft")
	if event.is_action_pressed("reset") && GameManager.Debug:
		reset()
	if event.is_action_pressed("goBackCombo"):
		Transition.ChangeScene("main","slideLeft")
	pass

func reset(): #reset whole map and player statistics
	#PlayerG.reset()
	get_tree().reload_current_scene()
#endregion

func SpawnPlayers() -> void:
	#region nodeReferences
	var players = Node.new(); players.name = "Players"; add_child(players)
	var playerTagNodes = Node.new(); playerTagNodes.name = "PlayerTags"; add_child(playerTagNodes)
	#endregion
	
	if GameManager.Debug: print("players are: ", Players)
	
	var maxIndex = Players -1
	var Index = 0; if !EnableKeyboard: Index = 0
	
	while Index <= maxIndex:
		var playerIndex = ActivePlayers[Index]
		#region Spawning of player
		var playerInstance = PLAYER.instantiate()
		playerInstance.name = "Player" + str(playerIndex+1); if playerIndex == -1: playerInstance.name = "Player"
		playerInstance.playerIndex = playerIndex
		players.add_child(playerInstance)
		playerNodeArray.append(playerInstance)
		#endregion
		
		#region adding nametags to players
		var playerLabel = Label.new()
		playerLabel.name = playerInstance.name
		playerLabel.text = PlayerG.playerNames[playerIndex]
		playerLabel.size = Vector2(400,23)
		playerLabel.set_anchors_preset(Control.PRESET_CENTER_TOP)
		playerLabel.set_horizontal_alignment(1)
		playerTagNodes.add_child(playerLabel)
		playerTagArray.append(playerLabel)
		#endregion
		
		print("spawning player ", playerIndex)
		Index += 1;
	if GameManager.Debug: print(playerNodeArray)
	if GameManager.Debug: print(playerTagArray)
	if GameManager.Debug: print("all player(s) has spawned")

func TagsFollowPlayer() :
	var totalPlayers = playerNodeArray.size()-1
	var playerNumber = 0
	
	while playerNumber <= totalPlayers:
		var playerTag = playerTagArray[playerNumber]
		var playerNode = playerNodeArray[playerNumber]
		
		playerTag.position.x = playerNode.position.x -200
		playerTag.position.y = playerNode.position.y -100
		playerNumber += 1

var timeLimit = PlayerG.FFA_TimeLimit
func UpdateTime():
	TIME.text = "TIME: " + str(timeLimit)
	timeLimit -= 1
	if timeLimit == -1:
		AudioG.playSFXEND("whistle",false)
		$UI/Panel.show()
		$Countdown.stop()
		PlayerG.gameFinished = true
		TIME.text = "GAME!"
		print("GAME FINISHED!!")
		$toResult.start()
		
func toResult():
	if GameManager.isIdle: Transition.ChangeScene("main", "slideLeft");return
	Transition.ChangeScene("results", "slideLeft")
	
	if GameManager.kiosk: PlayerG.kiosk_gameNum += 1

func newPowerUp():
	var amount = 2
	#var rngTime = randf_range(5,20) #default
	var rngTime = randf_range(5,20)
	var powerUp = load("res://Scenes/Prefabs/Powerup/power_up.tscn")
	for i in range(amount):
		var powerUp_instance = powerUp.instantiate()
		
		if !PlayerG.isSurvival: powerUp_instance.selectedPower = randi_range(1,6)
		else: powerUp_instance.selectedPower = 6
		add_child(powerUp_instance)
	
	$spawnPower.wait_time = rngTime
	


func _physics_process(delta):
	if GameManager.isIdle: titleAnim(delta)
	
	
var LogoMoveFreq: float = 1 ; var LogoRotFreq: float = 2
var LogoMoveAmp: float = 20 ; var LogoRotAmp: float = 50
var time = 0
func titleAnim(delta):
	time += delta
	var movement = cos(time*LogoMoveFreq)*LogoMoveAmp
	var _rotate = cos(time*LogoRotFreq)*LogoRotAmp
	%"Game Name".position.y += movement * delta
	%"Game Name".rotation_degrees += _rotate * delta / 10

var maps = {
	1: "FFA 01",
	2: "FFA 02",
	3: "FFA 03",
	4: "FFA 04",
	5: "FFA 05",
}
func nextIdleMap():
	var newMap = maps[randi_range(1,maps.size())] #default
	#var newMap = maps[2]#modified
	Transition.ChangeScene(newMap, "dissolve")
	pass

func leaderboards():
	var scores = GameManager.SCORES
	var text:String = "Leaderboard:"
	for names in scores:
		text += "\n" + str(scores[names]) + " : " + names
	%Leaderboard.text = text
	
#region survival
var lives = 5
func setLives(value): lives = value
func addLives(value): lives += value
func died():
	allModulate = 0.5
	lives -= 1
	$UI/TIME.text = "Lives: " + str(lives)
	if lives < 0: survival_GAME()

var spawnCam
var myLabel = Label.new()

func survival_GAME():
	AudioG.playSFXEND("whistle",false)
	$UI/Panel.show()
	$Countdown.stop()
	PlayerG.gameFinished = true
	TIME.text = "GAME!"
	print("GAME FINISHED!!")
	$toResult.start()
	pass
#endregion survival

var cam:Camera2D
func idle():
 #runs when the game is on idle or is unattended
	$"Game Name".show()
	$Timer.start()
	$Barriers/Walls.modulate = Color(5,3,5,1)
	
	var rng = randi_range(1,3)
	var camera = Camera2D.new()
	camera.limit_smoothed = true
	
	
	add_child(camera)
	if rng == 1:
		camera.position = Vector2(2560/2,1440/2)
		camera.zoom = Vector2(0.8,0.8)
	elif rng == 2:
		camera.position = Vector2(700,1440/2)
		camera.zoom = Vector2(1.5,1.5)
		cam = camera
	elif rng == 3:
		randomize()
		var rng2 = randi_range(0,7)
		camera.zoom = Vector2(1.5,1.5)
		camera.reparent(playerNodeArray[rng2])
		camera.position = Vector2(0,0)
		camera.position_smoothing_enabled = true
		
		camera.limit_left = -175; camera.limit_right = 2385
		camera.limit_top = -100; camera.limit_bottom = 1340
	
		await get_tree().create_timer(7.0).timeout
		randomize()
		rng2 = randi_range(0,7)
		camera.reparent(playerNodeArray[rng2])
		camera.position = Vector2(0,0)
		camera.limit_left = -175; camera.limit_right = 2385
		camera.limit_top = -100; camera.limit_bottom = 1340
		
		
		#camera.position = playerNodeArray[rng2]
