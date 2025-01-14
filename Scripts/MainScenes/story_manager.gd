extends Node
#region important variables
var isDialogue
var currentMap = "Prologue"
var usedSaveIndex = 0
const maps = [ #reference for Current Map variable
	"Prologue", #for tropikala player location
	"Tropikala", #prologue and chapter 1
	"Atsu Island", #chapter 2
	"Domageti", #chapter 3
	"Scharbi", #hapter 4
	"Mirage Island", #chapter 6
]
var objectives = [
	{
		"Prologue Complete": false,
		"Tropikala Complete": false,
		"Atsu Island Complete": false,
		"Domageti Complete": false,
		"Scharbi Complete": false,
		"Mirage Island Complete": false,
	},
	{
		"Prologue Complete": false,
		"Tropikala Complete": false,
		"Atsu Island Complete": false,
		"Domageti Complete": false,
		"Scharbi Complete": false,
		"Mirage Island Complete": false,
	},
	{
		"Prologue Complete": false,
		"Tropikala Complete": false,
		"Atsu Island Complete": false,
		"Domageti Complete": false,
		"Scharbi Complete": false,
		"Mirage Island Complete": false,
	},
	
	
]
var achievements = {
	"A New Companion": false, #complete the prologue
	"A Not So Fun Vacation": false, #complete Tropikala A side
}
#endregion important variables


func _ready() -> void:
	#startDialogue("Prologue","Start")
	pass

#region Dialogue
var dIndex = 0
var charSound = AudioG.characters
var playerName = "Owen"
var characters = [
	playerName,
	"Von",
]

var p1 = [playerName, "right", ["normal", "happy", "worried", "suspicious"], charSound["Oshiro"]]
var c2 = ["Von", "left", ["normal","excited"], charSound["Theo"]] 

var npc1 = ["Ric", "left", ["slow"], charSound["OIIA"]]
#dialogue
#[i][0] = character emotion
#[i][1] = character properties
#[i][1][0] = character name
#[i][1][1] = character direction
#[i][1][2] = emotions
#[i][1][3] = character sound
#[i][2] = character dialogue
var dialogue:Dictionary = {
	"Prologue" :{
		#region main storyline
		"Start" : [
			[p1[2][0], p1, "ugh.."],
			[p1[2][0], p1, "oh no.."],
			[p1[2][2], p1, "what have i done.."],
			[p1[2][2], p1, "this is my fault.."],
			[p1[2][0], p1, "i gotta fix this."],
			[p1[2][2], p1, "but how.."],
		],
		"New Companion" : [
			#["nothing", ["action", "full"], "you make your way to a path"],
			#["nothing", ["action", "full"], "you find a drone that you recognize"],
			#["nothing", ["action", "full"], "Press X to Interact!"],
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
		],
		"Tutorial Shooting": [
			[c2[2][1], c2, "let's practice here!"],
			[p1[2][0], p1, "okay?"],
			[c2[2][1], c2, "this is a great place to practice"],
			[p1[2][2], p1, "right.."],
			[c2[2][1], c2, "we can start by shooting those broken tanks over there"],
			[c2[2][1], c2, "they will get stored in my database where they can be safe."],
			[p1[2][2], p1, "ARE YOU INSANE!? THEY ARE HUMANS!"],
			[c2[2][1], c2, "if they are humans, then they can stay safe here."],
			[c2[2][1], c2, "they can always be summoned back again after the problems have been resolved."],
			[p1[2][0], p1, "oh okay, what a relief."],
			[c2[2][1], c2, "you can shoot the tanks there by pressing X(gamepad) or Space(keyboard)"],
			[p1[2][1], p1, "that’s it?"],
			[c2[2][1], c2, "we’ll find more things to look out for soon " + p1[0] + " ."],
			[p1[2][3], p1, "alright, i hope we can save the archipelago."],
		],
		"Tutorial Ricochet": [
			[p1[2][2], p1, "theres more!?"],
			[c2[2][1], c2, "yes " + p1[0] +"."],
			[c2[2][1], c2, "now i'm gonna teach you about ricochet."],
			[p1[2][3], p1, "the what now?"],
			[c2[2][1], c2, "about bouncing your bullets"],
			[p1[2][0], p1, "ohh"],
			[p1[2][0], p1, "yes okay? what about it?"],
			[c2[2][1], c2, "you can use walls and try to hit your opponents"],
			[p1[2][0], p1, "Seems easy enough"],
			[c2[2][1], c2, "Let's try it then!"],
		],
		"End": [
			[c2[2][1], c2, "That’s the most basic thing you need to know " + p1[0] +"!"],
			[p1[2][1], p1, "Wow, that’s so easy"],
			[p1[2][1], p1, "I think i can save the archipelago with this!"],
			[c2[2][1], c2, "We need to be serious now, the tanks that we are gonna encounter, will attack you. so better be cautious."],
			[p1[2][1], p1, "Alright, let’s go! i mean this is easy, what could go wrong?"],
		],
		#endregion main storyline
		
		#region misc
		"Ric01": [
			[npc1[2][0], npc1, "Huy"],
			[p1[2][0], p1, "Huh?"],
			[npc1[2][0], npc1, "I helped in this project"],
			[p1[2][0], p1, "What do you mean?"],
			[npc1[2][0], npc1, "I gave a name to one of the islands"],
			[npc1[2][0], npc1, "It's so funny"],
		],
		
		"Not Yet": [
			[p1[2][0], p1, "i shouldn't go there yet..."]
		]
		#endregion misc
		
		
	},
	"Chapter 1": {
		"start": [
			[p1[2][0], p1, "this is it.."],
			[p1[2][0], p1, "let's save them"],
		],
		#region misc
		"boundary": [
			[c2[2][0], c2, "you should't go there"],
		]
		#endregion misc
		
	}
}

var DialogueBox = preload("res://Scenes/MainScenes/dialogue_box.tscn")
var myDbox:DBOX
func startDialogue(chapter,part,node): #node is the node that calls the function
	if myDbox != null: return
	myDbox = DialogueBox.instantiate()
	myDbox.setDialogue(dialogue[chapter][part])
	node.add_child(myDbox)
	
	myDbox.dialogue_line_finished.connect(getDIndex)
	myDbox.dialogue_finished.connect(closeDbox)
	#myDbox
#endregion Dialogue

#region getters

func getDbox():
	return myDbox
#endregion getters

#region setters
func getDIndex(DIndex = dIndex):
	dIndex = DIndex
	return dIndex
func closeDbox():
	dIndex = 0
	myDbox.close()
	await myDbox.transition_finished
	myDbox.dialogue_finished.disconnect(closeDbox)
	myDbox = null
	
#endregion setters
