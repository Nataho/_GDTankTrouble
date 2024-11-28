extends Control

@onready var player: ColorRect = $Player
@onready var player1: ColorRect = $Player1
@onready var player2: ColorRect = $Player2
@onready var player3: ColorRect = $Player3
@onready var player4: ColorRect = $Player4	

var placement = [
	Vector2(352,257),
	Vector2(752,257),
	Vector2(1152,257),
	Vector2(1552,257),
	Vector2(1952,257),
]

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

func setPlacement(): 
	var participants = {}
	for num in range(-1,4):
		participants[PlayerG.playerNames[num]] = PlayerG.PlayerScore[num]["game score"]
	print(participants)
	
	print(participants)

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
