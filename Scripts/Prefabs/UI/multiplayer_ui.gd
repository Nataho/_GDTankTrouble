extends CanvasLayer

@onready var player: ColorRect = $Control/Scoring/Player
@onready var player1: ColorRect = $Control/Scoring/Player1
@onready var player2: ColorRect = $Control/Scoring/Player2
@onready var player3: ColorRect = $Control/Scoring/Player3
@onready var player4: ColorRect = $Control/Scoring/Player4

@onready var label: Label = $Control/Scoring/Player/Label
@onready var label1: Label = $Control/Scoring/Player1/Label
@onready var label2: Label = $Control/Scoring/Player2/Label
@onready var label3: Label = $Control/Scoring/Player3/Label
@onready var label4: Label = $Control/Scoring/Player4/Label

func _ready() -> void:
	scoreColors()
	updateScores()

func updateScores():
	label.text = str(PlayerG.PlayerScore[-1]["game score"])
	label1.text = str(PlayerG.PlayerScore[0]["game score"])
	label3.text = str(PlayerG.PlayerScore[2]["game score"])
	label2.text = str(PlayerG.PlayerScore[1]["game score"])
	label4.text = str(PlayerG.PlayerScore[3]["game score"])
	
	
func scoreColors():
	if -1 in PlayerG.activeTankColor: player.modulate = PlayerG.activeTankColor[-1]
	if 0 in PlayerG.activeTankColor: player1.modulate = PlayerG.activeTankColor[0]
	if 1 in PlayerG.activeTankColor: player2.modulate = PlayerG.activeTankColor[1]
	if 2 in PlayerG.activeTankColor: player3.modulate = PlayerG.activeTankColor[2]
	if 3 in PlayerG.activeTankColor: player4.modulate = PlayerG.activeTankColor[3]
