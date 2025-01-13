extends Node
@export var Version:String = "0.0.16"
@export var Debug:bool = true
@export var kiosk:bool = false #founders
var isIdle = false
var currentFocus
const Scenes = {
	"main": "res://Scenes/main.tscn",
	"modes":"res://Scenes/MainScenes/UI/mode_select.tscn",
	"campaign menu":"res://Scenes/MainScenes/campaign_menu.tscn",
	"tutorial": "res://Scenes/MainScenes/tutorial.tscn",
	"player menu": "res://Scenes/MainScenes/player_menu.tscn",
	"results": "res://Scenes/MainScenes/results.tscn",
	"loading": "res://Scenes/MainScenes/loading_screen.tscn",
	
	"tropikala": "res://Scenes/MainScenes/Campaign/Tropikala/tropikala.tscn",
	
	"level 1" : "res://Scenes/Prefabs/Levels/level1.tscn",
	
	"FFA 01": "res://Scenes/Prefabs/Levels/FFA/ffa_01.tscn",
	"FFA 02": "res://Scenes/Prefabs/Levels/FFA/ffa_02.tscn",
	"FFA 03": "res://Scenes/Prefabs/Levels/FFA/ffa_03.tscn",
	"FFA 04": "res://Scenes/Prefabs/Levels/FFA/ffa_04.tscn",
	"FFA 05": "res://Scenes/Prefabs/Levels/FFA/ffa_05.tscn",
	"FFA 06": "res://Scenes/Prefabs/Levels/FFA/ffa_06.tscn",
	
	"Bullet 01": "res://Scenes/Prefabs/Levels/Bullet/bullet_01.tscn",
	"Bullet 02": "res://Scenes/Prefabs/Levels/Bullet/bullet_02.tscn",
	
	
	"Survival 01": "res://Scenes/Prefabs/Levels/Survival/Survival_01.tscn",
}

#region handle saving and loading
var saving:Dictionary = {
	"leaderboard": SCORES,
}
func UpdateEVERYTHING():
	saving["leaderboard"] = SCORES
func Save():
	UpdateEVERYTHING()
	var saves = saving
	return saves

func SaveGame():
	var save_game = FileAccess.open("user://Save.save", FileAccess.WRITE)
	var json_string = JSON.stringify(Save())
	save_game.store_line(json_string)

func LoadGame():
	if not FileAccess.file_exists("user://Save.save"):
		return
	var save_game = FileAccess.open("user://Save.save", FileAccess.READ)
	
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		if parse_result == OK:
			var node_data = json.get_data()
			updateLeaderboard(node_data["leaderboard"])
			# Ensure that the keys are converted back to integers
#			var updated_names = {}
#			for key in node_data.keys():
#				updated_names[int(key)] = node_data[key]
			#updateNames(node_data["Names"])
			#if "Settings" in node_data: 
				#updateSettings(node_data["Settings"])
			#else: # Initialize with default settings if not present in save file
				#updateSettings({
					#"version": version,
					#"particles": true,
					#"fps": false,
					#"v-sync": 0,
					#"game settings": gameSet,
					#"sound": sound,
					#"statistics": statistics,
					#
				#})
			#updateGameSet(node_data["Settings"]["game settings"])
			#updateSound(node_data["Settings"]["sound"])
			#updateStatistics(node_data["Settings"]["statistics"])
			#print("load")

func updateLeaderboard(update): 
	#SCORES = update
	if update == null: return
	for names in update.keys():
		update[names] = int(update[names])
	SCORES = update
	add_to_leaderboard()
	if GameManager.Debug: print("updated leaderboard")
#endregion handle saving ans loading



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
	if Name in SCORES && SCORES[Name] > Score: return
	if Name == "test" || Name == "keyboard": return
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




#

#
