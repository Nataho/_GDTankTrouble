extends Node2D

signal objective_aNewCompanion

@export var interactable := false
@export var animation: anim = anim.FLOATING
@onready var player_dettection: Area2D = $playerDettection
@onready var animate: AnimationPlayer = $Animate
@onready var root: Node2D = $"../../.."

enum anim{
	FLOATING,
	LOOKING,
}

var isUp = false
var ourPlayer: Player
func connectSignals():
	if !interactable: player_dettection.area_entered.disconnect(playerDetected)
	objective_aNewCompanion.connect(aNewCompanion)

func aNewCompanion():
	pass

func _ready() -> void:
	forAnim(animation)
	connectSignals()

@onready var animTree: AnimationTree = $AnimationTree

func forAnim(animIndex):
	if animIndex == anim.FLOATING:
		animTree.set("parameters/look/add_amount",0)
	if animIndex == anim.LOOKING:
		animTree.set("parameters/look/add_amount",1)

func playerDetected(body):
	if !interactable: return
	if body.isPlayer: print(body.name)
	animate.play("InteractShow")
	
	isUp = true
	ourPlayer = body as Player
	ourPlayer.interacting.connect(interactNPC)

func playerLeft(body):
	if isUp:
		animate.play_backwards("InteractShow")
	
	isUp = false
	if !interactable: return
	ourPlayer.interacting.disconnect(interactNPC)
	ourPlayer = null

func interactNPC():
	if !isUp: return
	if StoryManager.isDialogue: return
	if !interactable: return
	
	print("interacting")
	StoryManager.startDialogue("Prologue", "New Companion", root)
	await StoryManager.myDbox.dialogue_finished
	root.objectives["new companion"] = true
	playerLeft(ourPlayer)
	interactable = false
