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
	"the MOUSE makes you and your bullet tiny but, hitting opponents becomes hard.",
	"use the MOUSE to get through tiny gaps and escape from enemies or surprise them",
	"the SPEED makes you rotate and move faster but, you are faster than your bullets.",
	"get behind your opponents to get an easy kill.",
	"use the walls to hit your opponents before they realize it.",
	"don't just focus on shooting your opponents, dodge their bullets as well.",
	"offense is the best defense, shoot the incoming bullets to deflect or destroy them.",
	"any suggestions? put it on the suggestion paper!!",
	"Certain maps feature strategic openings in the walls. Use these small gaps to aim and take out your opponents.",
	"Something exciting is coming your way—stay tuned tomorrow to uncover the mystery!", #founders
	"50 PESO REWARD!: FIND A WAY TO RECREATE THE SCALING BUG!www",
	"the game is meant to be chaotic. so everything that is not intended is part of the chaos",
	"don't be slow to react, you're an easy target.",
	"you should grab the power ups, it will be a blessing and a curse",
	"this game is made with Godot 4.3",
	"IT is the best!",
	"Game Dev is the Best!",
]

var maps = {
	1: "FFA 01",
	2: "FFA 02",
	3: "FFA 03",
}


var loadingTime = randf_range(5,10)
var isTimeValid = false
var animationTime

func loadingFinished():
	$MouseAnimate.play("ALL Jump"); $LoadingText.text = (loadingText[4])
	await $MouseAnimate.animation_finished
<<<<<<< Updated upstream
	var newMap = maps[randi_range(1,maps.size())] #default
	#var newMap = maps[1]#modified
=======
	#var newMap = maps[randi_range(1,maps.size())] #default
	var newMap = maps[2]#modified
>>>>>>> Stashed changes
	Transition.ChangeScene(newMap, "slideLeft")

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
		
