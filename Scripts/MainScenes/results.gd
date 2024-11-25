extends Control

@onready var player: ColorRect = $Player
@onready var player1: ColorRect = $Player1
@onready var player2: ColorRect = $Player2
@onready var player3: ColorRect = $Player3
@onready var player4: ColorRect = $Player4	

func _ready() -> void:
	Colors()
	UpdateStatistics()

func Colors():
	player.modulate = PlayerG.tankColor[-1]
	player1.modulate = PlayerG.tankColor[0]
	player2.modulate = PlayerG.tankColor[1]
	player3.modulate = PlayerG.tankColor[2]
	player4.modulate = PlayerG.tankColor[3]

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

var seconds:int = 15
func AutoExit():
	$"Time Left".text = "Automatic Exit: " + str(seconds)
	seconds -= 1
	if seconds < 0:
		$Timer.stop()
		Transition.ChangeScene("main","slideLeft")
	
	
