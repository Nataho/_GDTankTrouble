extends Control

var animIndex = 0
var animations = [
	"RESET",
	"Mouse Jump",
	"Elephant Jump",
	"Speed Jump",
	"ALL Jump"
]
var loadingText = [
	"Loading..",
	"Loading Scene",
	"Loading Assets",
	"Loading Environment",
	"Preparing Map",
]

var hints = [
	"the ELEPHANT makes you and your bullets bigger but, you become an easy target.",
	"the MOUSE makes you and your bullet tiny but, hitting opponents become hard.",
	"the SPEED makes you rotate and move faster but, you are faster than your bullets.",
	"get behind your opponents to get an easy kill.",
	"use the walls to hit enemies before they realize it.",
	"don't just focus on shooting enemies, dodge their bullets as well.",
	"offense is the best defense, shoot the incoming bullets to deflect or destroy them.",
	"any suggestions? put it on the suggestion paper!!",
]



var loadingTime = randf_range(5,10)
var isTimeValid = false
var animationTime

func loadingFinished():
	$MouseAnimate.play("ALL Jump"); $LoadingText.text = (loadingText[4])
	await $MouseAnimate.animation_finished
	Transition.ChangeScene("FFA 02", "slideLeft")

func timeSet():
	isTimeValid = false
	while !isTimeValid:
		var attempts = 0
		attempts += 1
		animationTime = randi_range(1,4)
		if loadingTime - animationTime >= 0: isTimeValid = true; print("get time attempts: ",attempts, "; animation time: ", animationTime)
	$Next.wait_time = animationTime
	$Next.start()

func _ready() -> void:
	timeSet()
	$Hints.text = hints[randi_range(0,hints.size()-1)]
	$MouseAnimate.play(animations[animIndex]); $LoadingText.text = (loadingText[animIndex])
	
	
	
func mouseEnd(anim_name: StringName) -> void:
	if animIndex == 0: animIndex += 1
	$MouseAnimate.play(animations[animIndex]); $LoadingText.text = (loadingText[animIndex])

func nextAnim():
	await $MouseAnimate.animation_finished
	animIndex += 1
	if animIndex > 3: loadingFinished(); return
	$MouseAnimate.play(animations[animIndex]); $LoadingText.text = (loadingText[animIndex])
	timeSet()
		