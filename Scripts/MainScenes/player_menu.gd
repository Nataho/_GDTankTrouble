extends CanvasLayer

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("goBack"):
		Transition.ChangeScene("main", "dissolve")
	if event is InputEventMouseMotion:
		var mouse_movement = event.relative
		$Unattended.start()
	#if event.is_action_pressed("reset"):
		#get_tree().reload_current_scene()
	pass

func _ready() -> void:
	$StartGame.disabled = true
	AudioG.playMusic("game menu")
	PlayerG.reset()
	#for key in Players:
		#Players[key].isAI = false

@onready var LineEdits = {
	-1: $"DisplayPlayers/Player0/-1",
	0: $"DisplayPlayers/Player1/0",
	1: $"DisplayPlayers/Player2/1",
	2: $"DisplayPlayers/Player3/2",
	3: $"DisplayPlayers/Player4/3",
	4: $"DisplayPlayers/Player5/4",
	5: $"DisplayPlayers/Player6/5",
	6: $"DisplayPlayers/Player7/6",
	7: $"DisplayPlayers/Player8/7",	
}

@onready var Players = {
	-1: $DisplayPlayers/Player0/Player,
	0: $DisplayPlayers/Player1/Player,
	1: $DisplayPlayers/Player2/Player,
	2: $DisplayPlayers/Player3/Player,
	3: $DisplayPlayers/Player4/Player,
	4: $DisplayPlayers/Player5/Player,
	5: $DisplayPlayers/Player6/Player,
	6: $DisplayPlayers/Player7/Player,
	7: $DisplayPlayers/Player8/Player,
	
}
var canKeyboard = 0

func StartGame():
	Transition.ChangeScene("loading", "slideRight")

#region Player Names
func submitPlayer0(value:String, index = -1):
	PlayerG.activeTankColor[index] = PlayerG.tankColor[index] #set default color
	if value == "": 
		Players[index].isPlayerMenu = true
		PlayerG.EnableKeyboard = false
		PlayerG.ActivePlayers.erase(index)
		canKeyboard = 0
		return
		
	if Players[index].isPlayerMenu:
		PlayerG.ActivePlayers.append(index)
		canKeyboard = 1
		
	PlayerG.playerNames[index] = value
	PlayerG.EnableKeyboard = true
	Players[index].isPlayerMenu = false
	Players[index].modulate = PlayerG.activeTankColor[index]
	
	PlayerG.isAI[index] = false
	
func submitPlayer1(value:String, index = 0):
	if value == "":
		Players[index].isPlayerMenu = true
		PlayerG.playerAmount -=1
		PlayerG.ActivePlayers.erase(index)
		return
	
	if Players[index].isPlayerMenu: 
		PlayerG.playerAmount +=1 ##temporary fix ############################################
		PlayerG.ActivePlayers.append(index)
		
	PlayerG.playerNames[index] = value
	Players[index].isPlayerMenu = false
	Players[index].modulate = PlayerG.tankColor[index]
	
	PlayerG.isAI[index] = false
	
func submitPlayer2(value:String, index = 1): 
	if value == "":
		Players[index].isPlayerMenu = true
		PlayerG.playerAmount -=1
		PlayerG.ActivePlayers.erase(index)
		return
	
	if Players[index].isPlayerMenu: 
		PlayerG.playerAmount +=1 ##temporary fix ############################################
		PlayerG.ActivePlayers.append(index)
	PlayerG.playerNames[index] = value
	Players[index].isPlayerMenu = false
	Players[index].modulate = PlayerG.tankColor[index]
	
	PlayerG.isAI[index] = false
	
func submitPlayer3(value:String, index = 2): 
	if value == "":
		Players[index].isPlayerMenu = true
		PlayerG.playerAmount -=1
		PlayerG.ActivePlayers.erase(index)
		return
	
	if Players[index].isPlayerMenu:
		PlayerG.playerAmount +=1 ##temporary fix ############################################
		PlayerG.ActivePlayers.append(index)
	PlayerG.playerNames[index] = value
	Players[index].isPlayerMenu = false
	Players[index].modulate = PlayerG.tankColor[index]
	
	PlayerG.isAI[index] = false
	
func submitPlayer4(value:String, index = 3): 
	if value == "":
		Players[index].isPlayerMenu = true
		PlayerG.playerAmount -=1
		PlayerG.ActivePlayers.erase(index)
		return
	
	if Players[index].isPlayerMenu:
		PlayerG.playerAmount +=1 ##temporary fix ############################################
		PlayerG.ActivePlayers.append(index)
	PlayerG.playerNames[index] = value
	Players[index].isPlayerMenu = false
	Players[index].modulate = PlayerG.tankColor[index]
	
	PlayerG.isAI[index] = false
	
func submitPlayer5(value:String, index = 4): 
	if value == "":
		Players[index].isPlayerMenu = true
		PlayerG.playerAmount -=1
		PlayerG.ActivePlayers.erase(index)
		return
	
	if Players[index].isPlayerMenu:
		PlayerG.playerAmount +=1 ##temporary fix ############################################
		PlayerG.ActivePlayers.append(index)
	PlayerG.playerNames[index] = value
	Players[index].isPlayerMenu = false
	Players[index].modulate = PlayerG.tankColor[index]
	
	PlayerG.isAI[index] = true

func submitPlayer6(value:String, index = 5): 
	if value == "":
		Players[index].isPlayerMenu = true
		PlayerG.playerAmount -=1
		PlayerG.ActivePlayers.erase(index)
		return
	
	if Players[index].isPlayerMenu:
		PlayerG.playerAmount +=1 ##temporary fix ############################################
		PlayerG.ActivePlayers.append(index)
	PlayerG.playerNames[index] = value
	Players[index].isPlayerMenu = false
	Players[index].modulate = PlayerG.tankColor[index]
	
	PlayerG.isAI[index] = true

func submitPlayer7(value:String, index = 6): 
	if value == "":
		Players[index].isPlayerMenu = true
		PlayerG.playerAmount -=1
		PlayerG.ActivePlayers.erase(index)
		return
	
	if Players[index].isPlayerMenu:
		PlayerG.playerAmount +=1 ##temporary fix ############################################
		PlayerG.ActivePlayers.append(index)
	PlayerG.playerNames[index] = value
	Players[index].isPlayerMenu = false
	Players[index].modulate = PlayerG.tankColor[index]
	
	PlayerG.isAI[index] = true

func submitPlayer8(value:String, index = 7): 
	if value == "":
		Players[index].isPlayerMenu = true
		PlayerG.playerAmount -=1
		PlayerG.ActivePlayers.erase(index)
		return
	
	if Players[index].isPlayerMenu:
		PlayerG.playerAmount +=1 ##temporary fix ############################################
		PlayerG.ActivePlayers.append(index)
	PlayerG.playerNames[index] = value
	Players[index].isPlayerMenu = false
	Players[index].modulate = PlayerG.tankColor[index]
	
	PlayerG.isAI[index] = true
#endregion Player Names

func SetTimeFFA(value: String):
	var intVal = value.to_int()
	PlayerG.FFA_TimeLimit = intVal
	$"FFA SetTime".text = str(intVal)

var canPlay = false

func check_avail():
	var playerCount = 0
	playerCount += canKeyboard
	playerCount += $DisplayPlayers/Player1.canPlay
	playerCount += $DisplayPlayers/Player2.canPlay
	playerCount += $DisplayPlayers/Player3.canPlay
	playerCount += $DisplayPlayers/Player4.canPlay
	playerCount += $DisplayPlayers/Player5.canPlay
	playerCount += $DisplayPlayers/Player6.canPlay
	playerCount += $DisplayPlayers/Player7.canPlay
	playerCount += $DisplayPlayers/Player8.canPlay
	#if GameManager.Debug: print(playerCount)
	
	if playerCount < 2: canPlay = false
	else: canPlay = true
	
	$StartGame.disabled = !canPlay

func Unattended():
	GameManager.isIdle = true
	var maxPlayers = 7
	var loopIndex = 0
	while loopIndex <= maxPlayers:
		PlayerG.ActivePlayers.append(loopIndex)
		PlayerG.activeTankColor[loopIndex] = PlayerG.tankColor[loopIndex]
		PlayerG.isAI[loopIndex] = true
		PlayerG.playerNames[loopIndex] = "Player " + str(loopIndex+1)
		
		loopIndex += 1
	Transition.ChangeScene("loading","slideRight")

#region set GameMode
func gamemode_survival(isDown:bool):
	if isDown:
		for slot in Players:
			if slot == -1: continue
			Players[slot].get_parent().setSurvival(true)
		$SURVIVAL.theme = load("res://Assets/_Settings/Themes/red.tres")
	else:
		$SURVIVAL.theme = null
		for slot in Players:
			if slot == -1: continue
			Players[slot].get_parent().setSurvival(false)

func hardMode(isDown:bool):
	PlayerG.isHardMode = isDown
	#= {
	#-1: $DisplayPlayers/Player0/Player,
	#0: $DisplayPlayers/Player1/Player,
	#1: $DisplayPlayers/Player2/Player,
	#2: $DisplayPlayers/Player3/Player,
	#3: $DisplayPlayers/Player4/Player,
	#4: $DisplayPlayers/Player5/Player,
	#5: $DisplayPlayers/Player6/Player,
	#6: $DisplayPlayers/Player7/Player,
	#7: $DisplayPlayers/Player8/Player,
	#
#}
#endregion set GameMode
