extends Node
@export var Version:String = "0.0.16"
@export var Debug:bool = true
@export var kiosk:bool = false #founders
var isIdle = false
const Scenes = {
	"main": "res://Scenes/main.tscn",
	"tutorial": "res://Scenes/MainScenes/tutorial.tscn",
	"player menu": "res://Scenes/MainScenes/player_menu.tscn",
	"results": "res://Scenes/MainScenes/results.tscn",
	"loading": "res://Scenes/MainScenes/loading_screen.tscn",
	
	"level 1" : "res://Scenes/Prefabs/Levels/level1.tscn",
	
	"FFA 01": "res://Scenes/Prefabs/Levels/FFA/ffa_01.tscn",
	"FFA 02": "res://Scenes/Prefabs/Levels/FFA/ffa_02.tscn",
	"FFA 03": "res://Scenes/Prefabs/Levels/FFA/ffa_03.tscn",
	"FFA 04": "res://Scenes/Prefabs/Levels/FFA/ffa_04.tscn",
	"FFA 05": "res://Scenes/Prefabs/Levels/FFA/ffa_05.tscn",
	
	"Bullet 01": "res://Scenes/Prefabs/Levels/Bullet/bullet_01.tscn",
	"Bullet 02": "res://Scenes/Prefabs/Levels/Bullet/bullet_02.tscn",
}

#region scoring
var SCORES = {
	"bh": 28,
	"von" : 63,
	"NEgg": 2,
	"judel": 9,
	"ram": 8,
	"hati": 3,
	#"owen": 123,
}

func add_to_leaderboard(Name = null,Score = null):
	#gets the value of the dictionary and sorts it by descending order
	if Name != null && Score != null: SCORES[Name] = Score
	var scorevalues = SCORES.values()
	scorevalues.sort()
	scorevalues.reverse()
	
	#checks the name if it is the same as te score placement
	var newScoreSet:Dictionary
	for score in scorevalues:
		for names in SCORES:
			if SCORES[names] == score:
				newScoreSet[names] = score
	SCORES = newScoreSet
	
	if Debug: print(SCORES)

#endregion scoring

func _ready() -> void:
	add_to_leaderboard()

func changeScene(scene: String):
	get_tree().change_scene_to_file(Scenes[scene])
