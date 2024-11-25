extends Node

const Animations = [
	"dissolve",
	"slideLeft",
	"slideRight",
	"slideDown",
	"slideUp",
]
@onready var Animate: AnimationPlayer = $Transition

func _ready() -> void:
	Animate.play("RESET")

func ChangeScene(scene:String, transition:String):
	Animate.play("RESET")
	#GameManager.changeScene(scene)
	
	if transition == "":
		GameManager.changeScene(scene)

	#region Transitions
	if transition == "dissolve":
		Animate.play("dissolve")
		await Animate.animation_finished
		GameManager.changeScene(scene)
		Animate.play_backwards("dissolve")
	
	elif transition == "slideLeft":
		Animate.play("slideLeft")
		await Animate.animation_finished
		GameManager.changeScene(scene)
		Animate.play("slideLeftEnd")
		
	elif transition == "slideRight":
		Animate.play_backwards("slideLeftEnd")
		await Animate.animation_finished
		GameManager.changeScene(scene)
		Animate.play_backwards("slideLeft")
	
	elif transition == "slideDown":
		Animate.play("slideDown")
		await Animate.animation_finished
		GameManager.changeScene(scene)
		Animate.play("slideDown")
		
	elif transition == "slideUp":
		Animate.play_backwards("slideDownEnd")
		await Animate.animation_finished
		GameManager.changeScene(scene)
		Animate.play_backwards("slideDown")
	#endregion
