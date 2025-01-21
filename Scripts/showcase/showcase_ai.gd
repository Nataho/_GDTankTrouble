extends Node2D
@onready var player: Player = $Player
@onready var cpu: Player = $CPU
@onready var transition: AnimationPlayer = $UI/Transition

var positions: Dictionary
func _ready() -> void:
	_setThreads()
	positions["player pos"] = player.position
	positions["player rot"] = player.rotations
	positions["cpu pos"] = cpu.position
	positions["cpu rot"] = cpu.rotation

func playerDied():
	$Timer.start()
	pass
var index = 0
func next():
	if index == 0:
		transition.play("slideLeft")
		await transition.animation_finished
		startPos()
		cpu.vision.hide()
		transition.play("slideLeftEnd")
	elif index == 1:
		transition.play("slideLeft")
		await transition.animation_finished
		startPos()
		cpu.showCollisionsAI = false
		cpu.CollisionsAI()
		player.Respawn()
		transition.play("slideLeftEnd")
	index += 1
func startPos():
	player.position = positions["player pos"]
	player.rotation = positions["player rot"]
	cpu.position = positions["cpu pos"]
	cpu.rotation = positions["cpu rot"]
	player.Respawn()
		

#region tests
var thread1: Thread
var frameReady:bool = false
func _setThreads():
	thread1 = Thread.new()
	thread1.start(_ourFunc)

func _exit_tree() -> void:
	thread1.wait_to_finish()

func _process(delta: float) -> void:
	if !frameReady: 
		frameReady = true
		thread1.start(_ourFunc)

func _ourFunc():
	print("i love you")
#endregion tests
