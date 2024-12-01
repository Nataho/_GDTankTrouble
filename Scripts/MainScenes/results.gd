extends Control

@onready var player: ColorRect = $Player
@onready var player1: ColorRect = $Player1
@onready var player2: ColorRect = $Player2
@onready var player3: ColorRect = $Player3
@onready var player4: ColorRect = $Player4

func _ready() -> void:
	if PlayerG.isSurvival: seconds = 500
	setPlacement()
	
	Colors()
	UpdateStatistics()

func Colors():
	
	if -1 in PlayerG.activeTankColor: player.modulate = PlayerG.activeTankColor[-1]
	#else: player.modulate = PlayerG.tankColor[-1]
	
	if 0 in PlayerG.activeTankColor: player1.modulate = PlayerG.activeTankColor[0]
	#else: player1.modulate = PlayerG.tankColor[0]
	
	if 1 in PlayerG.activeTankColor: player2.modulate = PlayerG.activeTankColor[1]
	#else: player2.modulate = PlayerG.tankColor[1]
	
	if 2 in PlayerG.activeTankColor: player3.modulate = PlayerG.activeTankColor[2]
	#else: player3.modulate = PlayerG.tankColor[2]
	
	if 3 in PlayerG.activeTankColor: player4.modulate = PlayerG.activeTankColor[3]
	#else: player4.modulate = PlayerG.tankColor[3]
	
	#player1.modulate = PlayerG.activeTankColor[0]
	#player2.modulate = PlayerG.activeTankColor[1]
	#player3.modulate = PlayerG.activeTankColor[2]
	#player4.modulate = PlayerG.activeTankColor[3]

func CalculateScores():
	var loop = 0
	var playerAmount = PlayerG.playerAmount
	var enabledKeyboard = PlayerG.EnableKeyboard
	while loop <= PlayerG.playerAmount:
		
		loop += 1

func UpdateStatistics():
	var Text:String
	if PlayerG.ActivePlayers.size() >= 1:
			Text = "game score: " + str(PlayerG.PlayerScore[placementOrder[0]]["game score"])+"\n"
			Text += "kills: " + str(PlayerG.PlayerScore[placementOrder[0]]["kills"]) +"\n"
			Text += "deaths: " + str(PlayerG.PlayerScore[placementOrder[0]]["deaths"])+"\n"
			Text += "suicide: " + str(PlayerG.PlayerScore[placementOrder[0]]["suicide"])+"\n"
			Text += "total score: " + str(PlayerG.PlayerScore[placementOrder[0]]["total score"])+"\n"
			$Player/Satistics.text = Text
			$Player/Name.text = PlayerG.playerNames[placementOrder[0]]
			player.modulate = 	PlayerG.activeTankColor[placementOrder[0]]
	else: player.hide()
	
	if PlayerG.ActivePlayers.size() >= 2:
		Text = "game score: " + str(PlayerG.PlayerScore[placementOrder[1]]["game score"])+"\n"
		Text += "kills: " + str(PlayerG.PlayerScore[placementOrder[1]]["kills"]) +"\n"
		Text += "deaths: " + str(PlayerG.PlayerScore[placementOrder[1]]["deaths"])+"\n"
		Text += "suicide: " + str(PlayerG.PlayerScore[placementOrder[1]]["suicide"])+"\n"
		Text += "total score: " + str(PlayerG.PlayerScore[placementOrder[1]]["total score"])+"\n"
		$Player1/Satistics.text = Text
		$Player1/Name.text = PlayerG.playerNames[placementOrder[1]]
		player1.modulate = PlayerG.activeTankColor[placementOrder[1]]
	else: player1.hide()
	
	if PlayerG.ActivePlayers.size() >= 3:
		Text = "game score: " + str(PlayerG.PlayerScore[placementOrder[2]]["game score"])+"\n"
		Text += "kills: " + str(PlayerG.PlayerScore[placementOrder[2]]["kills"]) +"\n"
		Text += "deaths: " + str(PlayerG.PlayerScore[placementOrder[2]]["deaths"])+"\n"
		Text += "suicide: " + str(PlayerG.PlayerScore[placementOrder[2]]["suicide"])+"\n"
		Text += "total score: " + str(PlayerG.PlayerScore[placementOrder[2]]["total score"])+"\n"
		$Player2/Satistics.text = Text
		$Player2/Name.text = PlayerG.playerNames[placementOrder[2]]
		player2.modulate = PlayerG.activeTankColor[placementOrder[2]]
	else: player2.hide()
	
	if PlayerG.ActivePlayers.size() >= 4:
		Text = "game score: " + str(PlayerG.PlayerScore[placementOrder[3]]["game score"])+"\n"
		Text += "kills: " + str(PlayerG.PlayerScore[placementOrder[3]]["kills"]) +"\n"
		Text += "deaths: " + str(PlayerG.PlayerScore[placementOrder[3]]["deaths"])+"\n"
		Text += "suicide: " + str(PlayerG.PlayerScore[placementOrder[3]]["suicide"])+"\n"
		Text += "total score: " + str(PlayerG.PlayerScore[placementOrder[3]]["total score"])+"\n"
		$Player3/Satistics.text = Text
		$Player3/Name.text = PlayerG.playerNames[placementOrder[3]]
		player3.modulate = PlayerG.activeTankColor[placementOrder[3]]
	else: player3.hide()
	
	
	if PlayerG.ActivePlayers.size() >= 5:
		Text = "game score: " + str(PlayerG.PlayerScore[4]["game score"])+"\n"
		Text += "kills: " + str(PlayerG.PlayerScore[4]["kills"]) +"\n"
		Text += "deaths: " + str(PlayerG.PlayerScore[4]["deaths"])+"\n"
		Text += "suicide: " + str(PlayerG.PlayerScore[4]["suicide"])+"\n"
		Text += "total score: " + str(PlayerG.PlayerScore[4]["total score"])+"\n"
		$Player4/Satistics.text = Text
		$Player4/Name.text = PlayerG.playerNames[placementOrder[4]]
		player4.modulate = PlayerG.activeTankColor[placementOrder[4]]
	else: player4.hide()

var placement = [
	Vector2(352, 452),
	Vector2(752, 452),
	Vector2(1152, 452),
	Vector2(1552, 452),
	Vector2(1952, 452),
]

@onready var playerIcons = {
	1: $Player,
	2: $Player1,
	3: $Player2,
	4: $Player3,
	5: $Player4,
}
#1st: (352,257)
#2nd: (752,257)
#3rd: (1152,257)
#4th: (1552,257)
#5th: (1952,257)
var placementOrder
func setPlacement():
	var scores = []
	for indexes in PlayerG.ActivePlayers:
		scores.append(PlayerG.PlayerScore[indexes]["game score"])
	scores.sort();scores.reverse()
	print (scores)
	
	var placements = {}
	var place = 1
	while place <= PlayerG.ActivePlayers.size():
		for score in scores: for indexes in PlayerG.ActivePlayers:
			if PlayerG.PlayerScore[indexes]["game score"] == score and not placements.has(indexes):
				placements[indexes] = place

				place += 1
		#print(place)
	print(placements)
	placementOrder = placements.keys()
	print(placements)
	#if -1 in PlayerG.ActivePlayers: 
		#playerIcons[1].position = placement[placements[-1]-1]
		#
	#else: playerIcons[1].hide()
	#
	#if 0 in PlayerG.ActivePlayers: playerIcons[2].position = placement[placements[0]-1]
	#else: playerIcons[2].hide()
	#
	#if 1 in PlayerG.ActivePlayers: playerIcons[3].position = placement[placements[1]-1]
	#else: playerIcons[3].hide()
	#
	#if 2 in PlayerG.ActivePlayers: playerIcons[4].position = placement[placements[2]-1]
	#else: playerIcons[4].hide()
	#
	#if 3 in PlayerG.ActivePlayers: playerIcons[5].position = placement[placements[3]-1]
	#else: playerIcons[5].hide()

var LogoMoveFreq: float = 1 ; var LogoRotFreq: float = 2
var LogoMoveAmp: float = 20 ; var LogoRotAmp: float = 50
var time = 0
func _physics_process(delta):
	time += delta
	var movement = cos(time*LogoMoveFreq)*LogoMoveAmp
	var _rotate = cos(time*LogoRotFreq)*LogoRotAmp
	$Crown.position.y += movement * delta
	$Crown.rotation_degrees += _rotate * delta / 10
	
	$Player/Name.scale.y += movement / 500
	$Player/Name.rotation_degrees += _rotate * delta / 10
	
	
	#var participants = {}
	#for num in range(1,6):
		#
		#if num-2 not in PlayerG.ActivePlayers:continue
		#
		#var tie
		#var breaker = 0
		#if PlayerG.PlayerScore[num]["deaths"] != 0:
			#tie = PlayerG.PlayerScore[num]["kills"] / PlayerG.PlayerScore[num]["deaths"]
			#breaker = tie / 10
			#
		#participants[num] = {
			#"name": PlayerG.playerNames[num],
			#"index": num,
			#"score": PlayerG.PlayerScore[num]["game score"] + breaker
		#}
#
	#var scores = []
	#for name in participants:
		#scores.append(participants[name]["score"])
	#scores.sort()
	#scores.reverse()
	#print("participants: ", participants)
#
	#var placements = {}
	#var rank = 1
	#for score in scores:
		#for index in participants:
			#if participants[index]["score"] == score and not placements.has(index):
				#placements[index] = rank
		#rank += 1
#
	#var Rank = 1
	#while Rank <= 5:
		#for index in participants:
			#if placements[index] == Rank:
				#print("Placement ", Rank, ": Participant ", index, " with ", participants[index]["score"], " points")
				#if Rank > 1 and playerIcons[participants[index]["index"]].position == playerIcons[participants[index - 1]["index"]].position:
					#Rank += 1
					#
				#playerIcons[participants[index]["index"]].position = placement[Rank - 2]
				#print(playerIcons[participants[index]["index"]].position)
		#Rank += 1


# Call the function to set placements
#setPlacement()



	
	#for name in participants:
		#print("Participant ", name, ": ", participants[name], " points, Placement: ", placements[name])

#1st: (352,257)
#2nd: (752,257)
#3rd: (1152,257)
#4th: (1552,257)
#5th: (1952,257)

var seconds:int = 15
func AutoExit():
	if GameManager.kiosk: $"Time Left".text = "Next Game: " + str(seconds)
	else: $"Time Left".text = "Automatic Exit: " + str(seconds)
	seconds -= 1
	if seconds < 0:
		$Timer.stop()
		if GameManager.kiosk && PlayerG.kiosk_gameNum < 2: 
			nextKioskMap()
			PlayerG.gameFinished = false
			PlayerG.PlayerScore = {
				-1 : {"kills":0, "deaths": 0, "suicide":0, "game score":0, "total score":0, "flag score": 0, "friendly fire": 0},
				0 : {"kills":0, "deaths": 0, "suicide":0, "game score":0, "total score":0, "flag score": 0, "friendly fire": 0},
				1 : {"kills":0, "deaths": 0, "suicide":0, "game score":0, "total score":0, "flag score": 0, "friendly fire": 0},
				2 : {"kills":0, "deaths": 0, "suicide":0, "game score":0, "total score":0, "flag score": 0, "friendly fire": 0},
				3 : {"kills":0, "deaths": 0, "suicide":0, "game score":0, "total score":0, "flag score": 0, "friendly fire": 0},
				4 : {"kills":0, "deaths": 0, "suicide":0, "game score":0, "total score":0, "flag score": 0, "friendly fire": 0},
				5 : {"kills":0, "deaths": 0, "suicide":0, "game score":0, "total score":0, "flag score": 0, "friendly fire": 0},
				6 : {"kills":0, "deaths": 0, "suicide":0, "game score":0, "total score":0, "flag score": 0, "friendly fire": 0},
				7 : {"kills":0, "deaths": 0, "suicide":0, "game score":0, "total score":0, "flag score": 0, "friendly fire": 0},
			}
			return
		Transition.ChangeScene("main","slideLeft")
		#Next game start in (pila ka secods). 
	
func exit(): Transition.ChangeScene("main","slideLeft")

var maps = {
	1: "FFA 01",
	2: "FFA 02",
	3: "FFA 03",
}

func nextKioskMap():
	var newMap = maps[randi_range(1,maps.size())] #default
	#var newMap = maps[2]#modified
	Transition.ChangeScene(newMap, "dissolve")
	pass
