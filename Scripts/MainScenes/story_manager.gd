extends Node
#region important variables
var isDialogue
#endregion important variables

func _ready() -> void:
	#startDialogue("Prologue","Start")
	pass

#region Dialogue
var charSound = AudioG.characters
var playerName = "Owen"
var characters = [
	playerName,
	"Von",
]

var p1 = [playerName, "right", ["normal", "happy", "worried", "suspicious"], charSound["Oshiro"]]

var c2 = ["Von", "left", ["normal","excited"], charSound["Theo"]] 

#dialogue
#[i][0] = character emotion
#[i][1][0] = character name
#[i][1][1] = character direction
#[i][1][2] = emotions
#[i][1][3] = character sound
#[i][2] = character dialogue
var dialogue:Dictionary = {
	"Prologue" :{
		"Start" : [
			[p1[2][0], p1, "ugh.."],
			[p1[2][0], p1, "oh no.."],
			[p1[2][2], p1, "what have i done.."],
			[p1[2][2], p1, "this is my fault.."],
			[p1[2][0], p1, "i gotta fix this."],
			[p1[2][0], p1, "fdsuhw ifdfvxyhwje wrksfhiegf iubcasytcarfiawg
			 bdifugdfai sudfuaiudf uahsdiufaiu sfvuw eavibaeub 
			daunruai ufcnsa udyfcau"],
			[p1[2][2], p1, "but how.."],
			["nothing", ["action", "full"], "you make your way to a path"],
			["nothing", ["action", "full"], "you find a drone that you recognize"],
			["nothing", ["action", "full"], "Press X to Interact!"],
			[c2[2][1], c2, "who might you be?"],
			[p1[2][0], p1, "my name is " + p1[0]],
			[c2[2][1], c2, "why hello there " + p1[0] + "! my name is " + c2[0] + " a personal assistant of such!"],
			[p1[2][0], p1, "a personal assistant? who are you assisting?"],
			[c2[2][0], c2, "I currently don't have a client. would you like to be my client?"],
			[p1[2][3], p1, "i don't know.."],
			[c2[2][1], c2, "I can help you navigate, do tasks for you and help you with what you need."],
			[p1[2][3], p1, "can you help me save the archipelago?"],
			[c2[2][1], c2, "as long as i can follow you, i will do whatever you say to my power!"],
			[p1[2][1], p1, "alright!!"],
			[c2[2][1], c2, "Fantastic!"],
			[c2[2][1], c2, "Together, we'll be unstoppable!"],
			[c2[2][1], c2, "Now, let's get started with some basic training"],
			[c2[2][1], c2, "I'll teach you everything you need to know about fighting and saving the archipelago"],
			[c2[2][1], c2, "Ready to become a Hero " + p1[0] + "?"],
			[p1[2][1], p1, "YEAH!!"],
			[c2[2][1], c2, "Let's go!!"],
		]
	},
	"Chapter 1": {
	}
}

var DialogueBox = preload("res://Scenes/MainScenes/dialogue_box.tscn")
func startDialogue(chapter,part,node): #node is the node that calls the function
	var myDbox:DBOX = DialogueBox.instantiate()
	myDbox.setDialogue(dialogue[chapter][part])
	node.add_child(myDbox)
	
	#myDbox
#endregion Dialogue
