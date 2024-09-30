extends Node2D
@export_range(-1,3,0.0) var playerAmount = 0

var Player = preload("res://Scenes/Prefabs/player.tscn")
var currentInstance = null

func _input(event):
	if event.is_action_pressed("reset"):
		reset()
	#if event.is_action_pressed("RemoteMissile"):
		#PlayerG.playerPower = !PlayerG.playerPower
func reset():
	PlayerG.reset()
	get_tree().reload_current_scene()

func _process(delta):
	PlayerTag()

func PlayerTag():
	$LPlayer.position.x = $Player.position.x -38; $LPlayer.position.y = $Player.position.y -100;
	$LPlayer1.position.x = $Player1.position.x -38; $LPlayer1.position.y = $Player1.position.y -100;
	$LPlayer2.position.x = $Player2.position.x -38; $LPlayer2.position.y = $Player2.position.y -100;
	$LPlayer3.position.x = $Player3.position.x -38; $LPlayer3.position.y = $Player3.position.y -100;
	$LPlayer4.position.x = $Player4.position.x -38; $LPlayer4.position.y = $Player4.position.y -100;

func reset_child_scene():
	if currentInstance:
		currentInstance.queue_free()  # Remove the existing instance
	currentInstance = Player.instance()  # Create a new instance
	add_child(currentInstance)  # Add the new instance to the main scene
	currentInstance.position = Vector2(100, 100)  # Set position or other properties as needed
