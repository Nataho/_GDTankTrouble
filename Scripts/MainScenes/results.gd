extends Control

@onready var player: ColorRect = $Player
@onready var player1: ColorRect = $Player1
@onready var player2: ColorRect = $Player2
@onready var player3: ColorRect = $Player3
@onready var player4: ColorRect = $Player4

func _ready() -> void:
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
	Text = "game score: " + str(PlayerG.PlayerScore[-1]["game score"])+"\n"
	Text += "kills: " + str(PlayerG.PlayerScore[-1]["kills"]) +"\n"
	Text += "deaths: " + str(PlayerG.PlayerScore[-1]["deaths"])+"\n"
	Text += "suicide: " + str(PlayerG.PlayerScore[-1]["suicide"])+"\n"
	Text += "total score: " + str(PlayerG.PlayerScore[-1]["total score"])+"\n"
	$Player/Satistics.text = Text
	$Player/Name.text = PlayerG.playerNames[-1]
	
	Text = "game score: " + str(PlayerG.PlayerScore[0]["game score"])+"\n"
	Text += "kills: " + str(PlayerG.PlayerScore[0]["kills"]) +"\n"
	Text += "deaths: " + str(PlayerG.PlayerScore[0]["deaths"])+"\n"
	Text += "suicide: " + str(PlayerG.PlayerScore[0]["suicide"])+"\n"
	Text += "total score: " + str(PlayerG.PlayerScore[0]["total score"])+"\n"
	$Player1/Satistics.text = Text
	
	Text = "game score: " + str(PlayerG.PlayerScore[1]["game score"])+"\n"
	Text += "kills: " + str(PlayerG.PlayerScore[1]["kills"]) +"\n"
	Text += "deaths: " + str(PlayerG.PlayerScore[1]["deaths"])+"\n"
	Text += "suicide: " + str(PlayerG.PlayerScore[1]["suicide"])+"\n"
	Text += "total score: " + str(PlayerG.PlayerScore[1]["total score"])+"\n"
	$Player2/Satistics.text = Text
	
	Text = "game score: " + str(PlayerG.PlayerScore[2]["game score"])+"\n"
	Text += "kills: " + str(PlayerG.PlayerScore[2]["kills"]) +"\n"
	Text += "deaths: " + str(PlayerG.PlayerScore[2]["deaths"])+"\n"
	Text += "suicide: " + str(PlayerG.PlayerScore[2]["suicide"])+"\n"
	Text += "total score: " + str(PlayerG.PlayerScore[2]["total score"])+"\n"
	$Player3/Satistics.text = Text
	
	Text = "game score: " + str(PlayerG.PlayerScore[3]["game score"])+"\n"
	Text += "kills: " + str(PlayerG.PlayerScore[3]["kills"]) +"\n"
	Text += "deaths: " + str(PlayerG.PlayerScore[3]["deaths"])+"\n"
	Text += "suicide: " + str(PlayerG.PlayerScore[3]["suicide"])+"\n"
	Text += "total score: " + str(PlayerG.PlayerScore[3]["total score"])+"\n"
	$Player4/Satistics.text = Text

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
	
	if -1 in PlayerG.ActivePlayers: 
		playerIcons[1].position = placement[placements[-1]-1]
		
	else: playerIcons[1].hide()
	
	if 0 in PlayerG.ActivePlayers: playerIcons[2].position = placement[placements[0]-1]
	else: playerIcons[2].hide()
	
	if 1 in PlayerG.ActivePlayers: playerIcons[3].position = placement[placements[1]-1]
	else: playerIcons[3].hide()
	
	if 2 in PlayerG.ActivePlayers: playerIcons[4].position = placement[placements[2]-1]
	else: playerIcons[4].hide()
	
	if 3 in PlayerG.ActivePlayers: playerIcons[5].position = placement[placements[3]-1]
	else: playerIcons[5].hide()

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
	$"Time Left".text = "Automatic Exit: " + str(seconds)
	seconds -= 1
	if seconds < 0:
		$Timer.stop()
		Transition.ChangeScene("main","slideLeft")
	
func exit(): Transition.ChangeScene("main","slideLeft")
