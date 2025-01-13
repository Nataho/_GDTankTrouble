extends Node2D

var selfNode = self
#region signals
signal tutsTextLineFinished
#endregion signals

#region objectives
var objectives = {
	"new companion": false,
	"tutorial shooting": false,
	"tutorial ricochet": false,
}
#endregion objectives


#region nodes
#r
@onready var players = [
	$Players/Player,
	$Players/Player2,
	$Players/Player3,
	$Players/Player4,
	$Players/Player5,
]

@onready var cameraCheckpoints = [
	$"Area Preview/checkpoints/Tutorial",
	$"Area Preview/checkpoints/Tutorial/CP_preview1",
	$"Area Preview/checkpoints/Tutorial/CP_preview2",
	
	$"Area Preview/checkpoints/Tutorial2/room",
	$"Area Preview/checkpoints/Tutorial2/CP_preview1",
	$"Area Preview/checkpoints/Tutorial2/CP_preview2",
	
	$"Area Preview/checkpoints/End/end",
	
]
@onready var checkpointSpawns = [
	$"Area Preview/checkpoints/Tutorial/spawn",
	$"Area Preview/checkpoints/Tutorial2/spawn",
]

@onready var main_cam: Camera2D = $mainCam
var mainCamZoom = 1

@onready var von: Node2D = $Npcs/start/Von
var playerPositions = {
	"prologue": [
		Vector2(2208,1049), #white
		Vector2(2095,1134), #blue 	(0,0)
		Vector2(2305,1134), #red 	(1,0)
		Vector2(2305,1232), #green 	(1,1)
		Vector2(2095,1232), #green	(0,1)
	],
	"chapter 1": [
		Vector2(7135, -690), #white
		Vector2(7050, -800), #blue
		Vector2(7050, -590), #red
		Vector2(6952, -590), #green
		Vector2(6952, -800), #yellow
	]
}

#endregion nodes
var skipStart = false
var playerName = ""
var OOBPlayer = null
#region basic functions
func _ready() -> void:
	playerCam = players[0]
	StoryManager.isDialogue = true
	
	getPlayerInfo()
	initializePlayers()
	#if !skipStart: startChapter() 
	await get_tree().create_timer(1).timeout
	
	#main_cam.reparent(players[0])
	main_cam.global_position = players[0].global_position
	
	await get_tree().create_timer(1.5).timeout
	startChapter()
	
func _process(delta: float) -> void:
	handleCam(delta)
	if isStart: playerOOB(delta)
	handleVon(delta)

func pauseGame():
	pass

func handleVon(delta):
	if !objectives["new companion"]: return
	var npcPos = von.global_position
	var playerPos = playerCam.global_position
	var border = 110
	var posStart = playerPos - Vector2(border,border)
	var posEnd = playerPos + Vector2(border,border)
	
	if npcPos.x >= posStart.x and npcPos.x <= posEnd.x and npcPos.y >= posStart.y and npcPos.y <= posEnd.y: return
	npcPos.x = lerpf(npcPos.x,playerPos.x,1.5*delta)
	npcPos.y = lerpf(npcPos.y,playerPos.y,1.5*delta)
	von.global_position = npcPos
	
func handleCam(delta):
	var camPos = main_cam.global_position
	var newCamPos:Vector2
	var camZoom = main_cam.zoom
	if checkpointCam != null: newCamPos = checkpointCam.global_position
	else: newCamPos = playerCam.global_position
	
	#var parentPos:Vector2 = main_cam.get_parent().position
	#newCamPos
	camZoom.x = lerpf(camZoom.x,mainCamZoom,1*delta)
	camZoom.y = lerpf(camZoom.y,mainCamZoom,1*delta)
	main_cam.zoom = camZoom
	
	camPos.x = lerpf(camPos.x,newCamPos.x,5*delta)
	camPos.y = lerpf(camPos.y,newCamPos.y,5*delta)
	main_cam.global_position = camPos
#endregion basic functions

#region playerHandler
func initializePlayers():
	
	var index = -1 #use index+1 for local index
	while index < 4: #idle
		if StoryManager.currentMap == "Tropikala": #for chapter 1
			players[index+1].global_position = playerPositions["chapter 1"][index+1]
			players[index+1].global_rotation_degrees = 90
			
		if players[index+1]:
			PlayerG.activeTankColor[index] = PlayerG.tankColor[index]
			PlayerG.ActivePlayers.append(index)
			PlayerG.playerNames[index] = playerName
			PlayerG.EnableKeyboard = true
			players[index+1].IdleEntered.connect(startOOB)
			players[index+1].IdleExited.connect(checkOOB)
			players[index+1].moved.connect(startCam)
		index +=1
	
var playerCam
var checkpointCam
var checkpointSpawn
func changeCamera(isPlayer = true, checkpoint = null):
	if isPlayer:
		for player:Player in players:           
			if player.isIdle: continue
			#main_cam.reparent(player)
			playerCam = player
			#main_cam.global_position = player.global_position
			break
	elif !isPlayer: 
		if checkpoint == null: return
		checkpointCam = checkpoint

var startedCam = false
func startCam(body):
	#startOOB(body)
	if startedCam: return
	print("start")
	startedCam = true
	for player in players:
		#player.moved.disconnect(startCam) 
		#player.idleTimer.start()
		pass
	changeCamera()

#var ptest:Player
func startOOB(body):
	print("oob body: ",body.playerIndex)
	if body.isIdle:
		OOBPlayer = body
	changeCamera()
	#for player in players:
			#breaawdasdk
	pass

func playerOOB(delta):
	return
	# Get the current position of the node
	#var OOBNode = players[1].global_position
	if !OOBPlayer: return
	#print(OOBPlayer.name)
	var OOBNode = OOBPlayer.global_position
	var camPos:Vector2 = main_cam.global_position
	# Define the boundaries of the area
	var area_start = main_cam.global_position - Vector2(2560/2, 1440/2)
	var area_end = main_cam.global_position + Vector2(2560/2, 1440/2)
	
	# Check if the node is within the area
	if OOBNode.x >= area_start.x and OOBNode.x <= area_end.x and OOBNode.y >= area_start.y and OOBNode.y <= area_end.y:
		#print("IB")  # Inside bounds
		pass 
	else:
		OOBNode.x = lerpf(OOBNode.x,camPos.x,0.5*delta)
		OOBNode.y = lerpf(OOBNode.y,camPos.y,0.5  *delta)
		OOBPlayer.global_position = OOBNode
		#print("OOB")  # Out of bounds

func checkOOB(body):
	#if checkpointCam != null: await get_tree().create_timer(5).timeout
		#return
	var OOBpos = body.global_position
	var area_start = main_cam.global_position - ((Vector2(2560, 1440)/2)/mainCamZoom)
	var area_end = main_cam.global_position + ((Vector2(2560, 1440)/2)/mainCamZoom)
	if OOBpos.x >= area_start.x and OOBpos.x <= area_end.x and OOBpos.y >= area_start.y and OOBpos.y <= area_end.y:
		#print("IB")  # Inside bounds
		pass
	else:
		print("tropikala: oob false")
		var rngPos = [
			Vector2(randi_range(-200,-50),randi_range(-200,200)),
			Vector2(randi_range(50,200),randi_range(-200,200))
		]
		if checkpointCam != null: body.global_position = checkpointSpawn.global_position + rngPos[randi_range(0,1)]
		else: body.global_position = playerCam.global_position + rngPos[randi_range(0,1)]
		#print("OOB")

#endregion playerHandler

#region setters
func getPlayerInfo(): #initialize
	skipStart = false #ssa#change to global variale
	playerName = "Owen"
#endregion setters

#region chapterFunctions
var isStart = false
func startChapter():
	if StoryManager.currentMap == "Tropikala":
		
		return
	StoryManager.startDialogue("Prologue", "Start", self)
	music("Prologue")
	await StoryManager.myDbox.dialogue_finished
	isStart = true
	tutsIndex = 0
	startTutsText(tutorials["Move"])

func music(value):
	var myAudio
	if value == "Prologue":
		AudioG.playMusic("Prologue 01")
	
		await AudioG.MUSIC.finished
		AudioG.playMusic("Prologue 02")
#endregion chapterFunctions

#region tutorial textBox
var cps = 10/20 #Characters per second
var text = ""
var tutorials = {
	"Move": [
		"TO MOVE ON KEYBOARD\n press W,A,S,D",
		"TO MOVE ON CONTROLLER\n rotate the left joystick",
	]
}

var tutsIndex = 0
func startTutsText(lib):
	print(tutsIndex)
	if tutsIndex >= lib.size():
		tutsIndex = 0
		text = ""
		return
	var tuts = lib[tutsIndex]
	TutsText(tuts)
	tutsIndex += 1
	await tutsTextLineFinished
	await get_tree().create_timer(5).timeout
	startTutsText(tutorials["Move"])
	await get_tree().create_timer(5).timeout
	%"Tutorial Text".hide()

var charIndex = 0
func TutsText(value:String):
	var textBuffer = ""
	
	text = value
	#playing = true; StoryManager.isDialogue = true
	
	if value == null: value = textBuffer #manage error
	if charIndex == 0: %"Tutorial Text".text = textBuffer
	
	if charIndex < value.length(): #checks length
		textBuffer += value[charIndex] #add character to text
		%"Tutorial Text".text += textBuffer #apply text
		charIndex += 1 #length
		
		await get_tree().create_timer(0.1*cps).timeout #0.1s timer
		TutsText(value) #reccursive function
	else: 
		charIndex = 0 #reset location
		tutsTextLineFinished.emit()
#endregion tutorial textBox

#region cameraCheckpoints
func dialogueTiming(dLogue):
	if dLogue == "": return
	if dLogue == "Tutorial Shooting":
		#print("shooting dlogue")
		var dIndex = StoryManager.getDIndex()
		print("dindex: ", dIndex)
		if dIndex == 4:
			#print("dindex:", StoryManager.getDIndex())
			checkpointCam = cameraCheckpoints[2]
			mainCamZoom = 2
		elif dIndex == 8:
			checkpointCam = cameraCheckpoints[1]
			mainCamZoom = 2.5
		elif dIndex > 8: return
		
	elif dLogue == "Tutorial Ricochet":
		#print("ricochet dlogue")
		var dIndex = StoryManager.getDIndex()
		if dIndex == 7:
			checkpointCam = cameraCheckpoints[5]
			mainCamZoom = 2.5
		elif dIndex > 7: return
		print("dindex: ", dIndex)

		
	await get_tree().create_timer(0.1).timeout
	print(dLogue)
	
	dialogueTiming(dLogue)
	
func Checkpoint_Tutorial(body):
	if !body.isPlayer: return
	playerCam = body
	checkpointCam = cameraCheckpoints[0]
	checkpointSpawn = checkpointSpawns[0]
	mainCamZoom = 0.9
	for player:Player in players: player.idleTimer.stop()
	
	if !objectives["new companion"]: return
	if objectives["tutorial shooting"]: return
	StoryManager.startDialogue("Prologue", "Tutorial Shooting", self)
	checkpointCam = cameraCheckpoints[1]
	mainCamZoom = 2.5
	
	dialogueTiming("Tutorial Shooting")
		
	
	await StoryManager.myDbox.dialogue_finished
	dialogueTiming("")
	checkpointCam = cameraCheckpoints[0]
	mainCamZoom = 0.9
	
	objectives["tutorial shooting"] = true
	
func Checkpoint_TutorialOut(body):
	if !body.isPlayer: return
	playerCam = body
	checkpointCam = null
	checkpointSpawn = null
	mainCamZoom = 1
	#for player:Player in players: player.idleTimer.stop()
	
	#await get_tree().create_timer(5).timeout
	#checkpointCam = null
	#for player:Player in players: player.idleTimer.start()


func Checkpoint_Tutorial2In(body):
	if !body.isPlayer: return
	playerCam = body
	checkpointCam = cameraCheckpoints[3]
	checkpointSpawn = checkpointSpawns[1]
	mainCamZoom = 0.85
	
	for player:Player in players: player.idleTimer.stop()
	
	if !objectives["new companion"]: return
	if !objectives["tutorial shooting"]: return
	if objectives["tutorial ricochet"]: return
	StoryManager.startDialogue("Prologue", "Tutorial Ricochet", self)
	checkpointCam = cameraCheckpoints[4]
	mainCamZoom = 3
	dialogueTiming("Tutorial Ricochet")
	
	await StoryManager.myDbox.dialogue_finished
	dialogueTiming("")
	
	checkpointCam = cameraCheckpoints[3]
	mainCamZoom = 0.85
	objectives["tutorial ricochet"] = true
func Checkpoint_Tutorial2Out(body):
	if !body.isPlayer: return
	playerCam = body
	checkpointCam = null
	checkpointSpawn = null
	mainCamZoom = 1

func Checkpoint_End(body):
	if !body.isPlayer: return
	playerCam = body
	checkpointCam = cameraCheckpoints[6]
	mainCamZoom = 3
	
	for player:Player in players: player.idleTimer.stop()
	
	StoryManager.startDialogue("Prologue", "End", self)
	await StoryManager.myDbox.dialogue_finished
	StoryManager.objectives["Prologue Complete"] = true
	Transition.ChangeScene("main","slideUp")
#endregion cameraCheckpoints
