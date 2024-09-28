extends Area2D

var playerIndex :int
@export var SPEED := 500.0


var velocity := Vector2.ZERO
var forward_vector

func GetGamepadIndex():
	playerIndex = get_parent().playerIndex
	pass

func _ready():
	GetGamepadIndex()
	PlayerG.pBulletCount[playerIndex] += 1
	print(playerIndex)
	var rot = deg_to_rad(rotation_degrees)
	forward_vector = PlayerG.playerForwardV[playerIndex] #for forward direction
	#print(rot)

func _physics_process(delta:float) -> void:
	if PlayerG.playerPower[playerIndex]:
		forward_vector = PlayerG.playerForwardV[playerIndex] #for controlled missile
	velocity = forward_vector * SPEED
	translate(velocity * delta)
	pass

func die():
	PlayerG.pBulletCount[playerIndex] -= 1
	queue_free()
	

func hit(area):
	print("HIT!")
	queue_free()
	get_parent().reset()
	pass
