extends CanvasLayer
class_name LIVES
var lives = {
	-1: 5,
	0: 5,
	1: 5,
	2: 5,
	3: 5,
}

var players

@onready var playerTextures = {
	-1: $"Control/5 Players/Panel/VBoxContainer/P_-1/Lives",
	0: $"Control/5 Players/Panel/VBoxContainer/P_0/Lives",
	1: $"Control/5 Players/Panel/VBoxContainer/P_1/Lives",
	2: $"Control/5 Players/Panel/VBoxContainer/P_2/Lives",
	3: $"Control/5 Players/Panel/VBoxContainer/P_3/Lives",
}

@onready var playerContainers = {
	-1: $"Control/5 Players/Panel/VBoxContainer/P_-1",
	0: $"Control/5 Players/Panel/VBoxContainer/P_0",
	1: $"Control/5 Players/Panel/VBoxContainer/P_1",
	2: $"Control/5 Players/Panel/VBoxContainer/P_2",
	3: $"Control/5 Players/Panel/VBoxContainer/P_3",
}
var rescue = false
var showingAll = false
var totalLives = 0
var tankRescue = 0


func _ready() -> void:
	for index in lives:
		if players[index+1].isIdle:
			playerContainers[index].hide()
	showAll()
	checkLives()

func showAll():
	$Timer.start()
	if !showingAll:
		$Animate.play("ShowAll")
		showingAll = true
	await $Timer.timeout
	$Animate.play("ShowIndividual")
	showingAll = false
	

func setNodes(nodes):
	players = nodes

func checkLives():
	var gotLives = 0
	
	for index in lives:
		var deads = 0
		#if players[index+1].isIdle:
			#continue
		gotLives += lives[index]
		if lives[index] == -1: 
			deads += 1
			gotLives += 1
		playerTextures[index].text = "x" + str(lives[index] + deads)
		playerContainers[index].show()
		
	totalLives = gotLives
	$Control/Lives.text = "x" + str(totalLives)
	await get_tree().create_timer(0.2).timeout
	checkLives()

func deductLife(index):
	if lives[index] == -1: return
	lives[index] -= 1
	print( index, ": ", lives[index])

func rescueTanks():
	if StoryManager.isDialogue:
		#%CountDown.hide()
		countdown(11)
		return
	if !rescue:
		%CountDown.hide()
		countdown(11)
		return
	tankRescue += 1
	
	print(tankRescue)
	if tankRescue < 3: return 
	tankRescue = 0
	rescue = false
	for index in lives:
		if lives[index] <= 0: lives[index] = 1
	$PanelAnimate.play("Goods")

func startRescue():
	rescue = true
	$PanelAnimate.play("Warn")

func countdown(count):
	if count == 11: 
		%CountDown.hide()
		return
	if StoryManager.isDialogue:
		countdown(11)
		return
	%CountDown.text = str(count)
	%CountDown.show()
