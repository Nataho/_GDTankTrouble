extends Node
@export var Version:String = "0.0.16"
@export var Debug:bool = true

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
	
	"Bullet 01": "res://Scenes/Prefabs/Levels/Bullet/bullet_01.tscn",
	"Bullet 02": "res://Scenes/Prefabs/Levels/Bullet/bullet_02.tscn",
}

func changeScene(scene: String):
	get_tree().change_scene_to_file(Scenes[scene])
