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
	if GameManager.Debug:
		if PlayerG.FFA_TimeLimit == 0:
			$Countdown.stop()
	
	
	if OS.get_name() == "Android":
		Android()
	print(PlayerG.isAI)
	ActivePlayers = PlayerG.ActivePlayers
	#Players = PlayerG.playerAmount #########NOT A PART OF THE SNIPPET
	Players = PlayerG.ActivePlayers.size()
	EnableKeyboard = PlayerG.EnableKeyboard
	AudioG.playMusic("FFA 1")
	SpawnPlayers()
	#region testing
	print("entering players: ", PlayerG.ActivePlayers)
	print(Players)
	#endregion

func Android():
	var mobileUI = load("res://InGameUI.tscn")
	var mobileUI_Instance = mobileUI.instantiate()
	add_child(mobileUI_Instance)

func _process(delta: float) -> void:
	TagsFollowPlayer()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("reset"):
		reset()

func reset(): #reset whole map and player statistics
	PlayerG.reset()
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
	Transition.ChangeScene("results", "slideLeft")

func newPowerUp():
	var amount = 2
	var rngTime = randf_range(5,20)
	var powerUp = load("res://Scenes/Prefabs/Powerup/power_up.tscn")
	for i in range(amount):
		var powerUp_instance = powerUp.instantiate()
		powerUp_instance.selectedPower = randi_range(1,3)
		add_child(powerUp_instance)
	
	$spawnPower.wait_time = rngTime
	
