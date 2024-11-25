extends Node2D

@onready var tutorialLabel1: Label = $"CanvasLayer/Control/Tutorial Label 1"
@onready var photo = $CanvasLayer/Control/tuts
@onready var animate = $AnimationPlayer

func exitTuts():
	Transition.ChangeScene("main","")

func _ready() -> void:
	Tuts()
	
	
func _physics_process(delta: float) -> void:
	pass

var TutsIndex = 0
func Tuts():
	if TutsIndex == 0:
		PlayerG.PlayerMoved = false
		tutorialLabel1.text = "on regular controllers, use the left joystick to move forward and back."
		animate.play("move")
		
	elif TutsIndex == 1:
		PlayerG.PlayerRotated = false
		tutorialLabel1.text = "on regular controllers, use the right joystick to rotate left and right. or use the east and west buttons."
		animate.play("move to rotate")
		await animate.animation_finished
		animate.play("rotate")
		
	elif TutsIndex == 2:
		tutorialLabel1.text = "on regular controllers, use the right shoulder or south button to shoot"
		animate.play("shoot")
		

var timerStarted: bool = false
func update_():
	if GameManager.Debug: print(PlayerG.PlayerRotated, " ", timerStarted, " ", TutsIndex)
	if PlayerG.PlayerMoved  && !timerStarted && TutsIndex == 0:
		$Timer.start()
		timerStarted = true
	elif PlayerG.PlayerRotated  && !timerStarted && TutsIndex == 1:
		$Timer.start()
		timerStarted = true
	elif PlayerG.PlayerShot  && !timerStarted && TutsIndex == 2:
		$Timer.start()
		timerStarted = true

func next():
	TutsIndex += 1; $Timer.stop()
	Tuts()
	timerStarted = false

var moveTuts = {
	3: "res://Assets/Photos/move 1.png",
	2: "res://Assets/Photos/move 2.png",
	1: "res://Assets/Photos/move 3.png"
}

var rotateTuts = {
	3: "res://Assets/Photos/rotate 1.png",
	2: "res://Assets/Photos/rotate 2.png",
	1: "res://Assets/Photos/rotate 3.png"
}

#region test
var photoCycles = 3
var REFERENCEcycles = photoCycles
var tuts = 2
func photoCycle():
	$"Photo Cycle".wait_time = .5
	if tuts == 1: photo.texture = load(moveTuts[REFERENCEcycles])
	elif tuts == 2: photo.texture = load(rotateTuts[REFERENCEcycles])
	REFERENCEcycles -= 1
	if REFERENCEcycles == 0: REFERENCEcycles = photoCycles; $"Photo Cycle".wait_time = 2
#endregion
