extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var game_paused : bool = false:
	get:
		return game_paused
	set(value):
		game_paused = value
		get_tree().paused = not game_paused

#func _process(delta):
	#if Input.is_action_pressed("Pause") and get_tree().paused == true:
		#$"../CanvasLayer2/CanvasLayer".hide()
		#get_tree().paused = false
	#elif Input.is_action_pressed("Pause") and get_tree().paused == false:
		#$"../CanvasLayer2/CanvasLayer".show()
		#get_tree().paused = true

#func _input(event : InputEvent):
	#if event.is_action_pressed("Pause") and get_tree().paused == true:
		#$"../CanvasLayer2/CanvasLayer".show()
		#get_tree().paused = false
	#elif event.is_action_pressed("Pause") and get_tree().paused == false:
		#$"../CanvasLayer2/CanvasLayer".hide()
		#get_tree().paused = true

#func _on_pause_pressed():
	#$"../CanvasLayer2/CanvasLayer".show()
	#get_tree().paused = true
