extends CharacterBody2D

var playerIndex :int
@export var SPEED := 500.0


#var velocity := Vector2.ZERO
var forward_vector

var dir : float
var spawnPos : Vector2
var spawnRot : float

func GetGamepadIndex():
	playerIndex = get_parent().playerIndex
	pass

func _ready():
	GetGamepadIndex()
	PlayerG.pBulletCount[playerIndex] += 1
	print("Player ", playerIndex, "has shot")
	forward_vector = PlayerG.playerForwardV[playerIndex] #for forward direction ####
	velocity = forward_vector * SPEED

func _physics_process(delta:float) -> void:
	var collision = move_and_collide(velocity*delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
	pass

func die():
	PlayerG.pBulletCount[playerIndex] -= 1
	queue_free()
	
func hit(body):
	if body.name == "Player" or body.name == "Player1" or body.name == "Player2" or body.name == "Player3" or body.name == "Player4":
		print(body.name)
		print("HIT!")
		body.Spawned = false
		body.CoastClear = false
		body.Died()
		PlayerG.pBulletCount[playerIndex] -= 1
		queue_free()
	elif body.name == "Walls":
		print("wall")
