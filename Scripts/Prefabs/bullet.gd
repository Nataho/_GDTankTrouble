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
	$shadow.rotation_degrees -= spawnRot
	
	
	AudioG.playSFX("bulletShoot",true)
	GetGamepadIndex()
	modulate = PlayerG.activeTankColor[playerIndex] #color
	PlayerG.pBulletCount[playerIndex] += 1
	if GameManager.Debug: print("Player ", playerIndex, " has shot")
	forward_vector = PlayerG.playerForwardV[playerIndex] #for forward direction ####
	velocity = forward_vector * SPEED

func _physics_process(delta:float) -> void:
	Collisions(delta)
	
func Collisions(delta:float) -> void:
	var collision = move_and_collide(velocity*delta)
	var collisionBody
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		collisionBody = collision.get_collider()
	if collisionBody != null and collisionBody.name == "Walls":
		AudioG.playSFX("bulletBounce",true)
	if collisionBody != null and collisionBody.name == "Bullet":
		if GameManager.Debug: print("bullet has collided")
		queue_free(); PlayerG.pBulletCount[playerIndex] -=1
		collisionBody.queue_free(); PlayerG.pBulletCount[collisionBody.playerIndex] -=1
		AudioG.playSFX2("bulletCollide",true)
	collisionBody = null

func die():
	PlayerG.pBulletCount[playerIndex] -= 1
	queue_free()
	
func hit(body):
	if body in get_tree().get_nodes_in_group("Player"):
		if GameManager.Debug: print("HIT!")
		body.Spawned = false
		body.CoastClear = false
		body.Died()
		AudioG.playSFX3("playerDie",true)
		PlayerG.pBulletCount[playerIndex] -= 1
		PlayerG.PlayerScore[body.playerIndex]["deaths"] += 1
		queue_free()
		if body.playerIndex == playerIndex: #if bullet has hit the sender 
			PlayerG.PlayerScore[playerIndex]["game score"] -= 1
			if PlayerG.PlayerScore[playerIndex]["game score"] < 0: PlayerG.PlayerScore[playerIndex]["game score"] = 0
		
			PlayerG.PlayerScore[playerIndex]["suicide"] += 1
		else:
			PlayerG.PlayerScore[playerIndex]["kills"] += 1
			PlayerG.PlayerScore[playerIndex]["game score"] += 1
		if GameManager.Debug: print("Player ", playerIndex, "'s score is: ", PlayerG.PlayerScore[playerIndex])
