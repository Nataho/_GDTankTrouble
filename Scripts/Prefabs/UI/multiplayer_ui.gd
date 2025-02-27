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

@onready var players = [
	player,
	player1,
	player2,
	player3,
	player4,
]

@onready var labels = [
	label,
	label1,
	label2,
	label3,
	label4
]
var team_scores: Dictionary
var team_colors: Array
func _ready() -> void:
	get_scores()
	scoreColors()
	updateScores()

func updateScores():
	get_scores()
	scoreColors()
	
	var index = 0
	while index <= 4:
		labels[index].text = str(team_scores[team_colors[index]])
		index += 1
	#label.text = str(PlayerG.PlayerScore[-1]["game score"])
	#label1.text = str(PlayerG.PlayerScore[0]["game score"])
	#label3.text = str(PlayerG.PlayerScore[2]["game score"])
	#label2.text = str(PlayerG.PlayerScore[1]["game score"])
	#label4.text = str(PlayerG.PlayerScore[3]["game score"])
	pass
	
	
func scoreColors():
	#if -1 in PlayerG.activeTankColor: player.modulate = PlayerG.activeTankColor[-1]
	#if 0 in PlayerG.activeTankColor: player1.modulate = PlayerG.activeTankColor[0]
	#if 1 in PlayerG.activeTankColor: player2.modulate = PlayerG.activeTankColor[1]
	#if 2 in PlayerG.activeTankColor: player3.modulate = PlayerG.activeTankColor[2]
	#if 3 in PlayerG.activeTankColor: player4.modulate = PlayerG.activeTankColor[3]
	var index = 0
	while index <= 4:
		players[index].modulate = team_colors[index]
		index += 1

func get_scores():
	var scores = []
	var index = 0
	for color in PlayerG.teamScore:
		scores.append(PlayerG.teamScore[color])
	scores.sort()
	scores.reverse()
	
	var scoreDict:Dictionary
	for score in scores:
		for color in PlayerG.teamScore:
			if PlayerG.teamScore[color] == score:
				scoreDict[color] = score
	
	team_scores = scoreDict
	team_colors = team_scores.keys()
	
	PlayerG.teamScore = team_scores
	if GameManager.Debug: print(team_colors)
