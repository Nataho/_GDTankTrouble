extends Node
#can also count as settings

@export var isActive = false
@export var isFPSActive = true
@export var goodFPS = 0
@export var warnFPS = 0

@onready var node_fps: Label = $Ui/FPS

var settings = {
	"graphics":{
		"show fps": false,
		"show particles": true,
	}
}

func _ready() -> void:
	if isFPSActive: runFPS(isFPSActive)

#region FPS counter
func runFPS(run:bool = true):
	isFPSActive = run
	_showFPS()

func _showFPS():
	if !isFPSActive: 
		print("DEBUG: stopped showing FPS")
		node_fps.hide()
		return
	node_fps.show()

	var fps = Engine.get_frames_per_second()
	node_fps.text = "FPS: " + str(fps)
	node_fps.modulate = Color.WHITE
	if fps <= warnFPS: node_fps.modulate = Color.RED
	if fps >= goodFPS: node_fps.modulate = Color.GREEN
	
	await get_tree().create_timer(0.5).timeout
	_showFPS()
#endregion FPS counter
