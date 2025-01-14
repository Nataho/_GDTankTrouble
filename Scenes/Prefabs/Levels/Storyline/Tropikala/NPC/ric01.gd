extends Node2D

@export var interactable := false
@onready var player_dettection: Area2D = $playerDettection
@onready var animate: AnimationPlayer = $Animate
@onready var root: Node2D = $"../../.."

var isUp = false
var ourPlayer: Player

func _ready() -> void:
	connectSignals()

func connectSignals():
	if !interactable: player_dettection.area_entered.disconnect(playerDetected)
	
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
	#ourPlayer = null

func interactNPC():
	if !isUp: return
	if StoryManager.isDialogue: return
	if !interactable: return
	
	print("interacting ric01")
	StoryManager.startDialogue("Prologue", "Ric01", root)
	await StoryManager.myDbox.dialogue_finished
