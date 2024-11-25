extends Node2D

func _ready():
	PlayerG.reset()
	AudioG.playMusic("main menu")

func buttonPlay():
	AudioG.playSFX("button press",0)
	Transition.ChangeScene("player menu","slideRight")

func buttonTutorial():
	Transition.ChangeScene("tutorial","dissolve")

func debug():
	get_tree().change_scene_to_file("res://Scenes/MainScenes/player_menu.tscn")
