extends Node2D

const PLAYER = preload("res://Scenes/Prefabs/player.tscn")

#will contain all of the player tags or player names
var playerTagArray = [] 
var playerNodeArray = []

#region nodeReferences
@onready var players: Node = $Players
@onready var playerTagNodes: Node = $PlayerTags
#endregion

@export_range(0,4,0.1) var Players:int =  1
@export var EnableKeyboard: bool = false

#region Important Stuff
func _ready() -> void:
	AudioG.playMusic("wii tanks 1")
	SpawnPlayers()

func _process(delta: float) -> void:
	TagsFollowPlayer()

func _input(event: InputEvent) -> void:
	if GameManager.Debug: if event.is_action_pressed("reset"):
		reset()

func reset(): #reset whole map and player statistics
	PlayerG.reset()
	get_tree().reload_current_scene()
#endregion

func SpawnPlayers() -> void:
	if GameManager.Debug: print("players are: ", Players)
	
	var maxIndex = Players -1
	var playerIndex = -1; if !EnableKeyboard: playerIndex = 0
	
	while playerIndex <= maxIndex:
		
		#region Spawning of player
		var playerInstance = PLAYER.instantiate()
		playerInstance.name = "Player" + str(playerIndex+1); if playerIndex == -1: playerInstance.name = "Player"
		playerInstance.playerIndex = playerIndex
		#playerInstance.add_to_group("Player")
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
		
		if GameManager.Debug: print("spawning player ", playerIndex)
		playerIndex += 1;
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
