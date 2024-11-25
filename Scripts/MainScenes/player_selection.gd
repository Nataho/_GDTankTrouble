extends Control

#region NODES
@onready var player: CharacterBody2D = $Player
@onready var color_select = $ColorSelect.get_popup()
@onready var computer: Button = $Computer

#endregion
@export_range (0,7,0.1) var playerIndex := 0
@export var isAI := false
@onready var defaultColor = PlayerG.tankColor[playerIndex]

var buttonColor = {
	"green": "res://Assets/_Settings/Themes/green.tres",
	"blue": "res://Assets/_Settings/Themes/blue.tres",
	"yellow": "res://Assets/_Settings/Themes/yellow.tres"
}

#region Startup
func _ready() -> void:
	$ColorSelect.selected = playerIndex
	$Name.placeholder_text = "Controller " + str(playerIndex + 1)
	
	player.playerIndex = playerIndex
	PlayerG.isAI[playerIndex] = false
	PlayerG.activeTankColor[playerIndex] = defaultColor
	color_select.id_pressed.connect(setColor)

func setColor(id):
	var itemName = color_select.get_item_text(id)
	PlayerG.activeTankColor[playerIndex] = PlayerG.tankColor[id]
	player.modulate = PlayerG.activeTankColor[playerIndex]
#endregion


func submitPlayer(value:String):
	if value == "": 
		player.isPlayerMenu = true
		PlayerG.EnableKeyboard = false
		PlayerG.ActivePlayers.erase(playerIndex)
		return
		
	if player.isPlayerMenu:
		PlayerG.ActivePlayers.append(playerIndex)
		
	PlayerG.playerNames[playerIndex] = value
	PlayerG.EnableKeyboard = true
	player.isPlayerMenu = false
	player.modulate = PlayerG.activeTankColor[playerIndex]

func setComputer():
	isAI = !isAI
	if isAI:
		PlayerG.isAI[playerIndex] = true
		computer.theme = load(buttonColor["blue"])
		$Name.placeholder_text = "Computer " + str(playerIndex + 1)
	else:
		PlayerG.isAI[playerIndex] = false
		computer.theme = load(buttonColor["green"])
		$Name.placeholder_text = "Controller " + str(playerIndex + 1)
