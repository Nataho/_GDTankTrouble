extends CharacterBody2D

var playerIndex :int
@export var SPEED := 500.0

#var velocity := Vector2.ZERO
var forward_vector
var isMultiShot = false
var multiShotCount = 0

var dir : float
var spawnPos : Vector2
var spawnRot : float
var isCampaign: bool
var isAI := false

func GetGamepadIndex():
	playerIndex = get_parent().playerIndex
	pass

func _ready():
	print(isCampaign)
	print("color p1: ", PlayerG.activeTankColor)
	$shadow.rotation_degrees -= spawnRot
	
	AudioG.playSFX("bulletShoot",true)
	GetGamepadIndex()
	if !isCampaign: modulate = PlayerG.activeTankColor[playerIndex] #color
	else:  modulate = get_parent().modulate
	PlayerG.pBulletCount[playerIndex] += 1
	if GameManager.Debug: print("Player ", playerIndex, " has shot")
	
	if !isMultiShot: forward_vector = PlayerG.playerForwardV[playerIndex] #afor forward wdirection ####
	else: 
		if multiShotCount == 0: forward_vector =  PlayerG.playerForwardV10[playerIndex]
		else: forward_vector =  PlayerG.playerForwardV_10[playerIndex]
	velocity = forward_vector * SPEED

func _physics_process(delta:float) -> void:
	Collisions(delta)
	
func Collisions(delta:float) -> void:
	var collision = move_and_collide(velocity*delta)
	var collisionBody
	if collision:
		collisionBody = collision.get_collider()
		if collisionBody != null and collisionBody.name == "Bullet":
			if GameManager.Debug: print("bullet has collided")
			queue_free(); PlayerG.pBulletCount[playerIndex] -=1
			collisionBody.queue_free(); PlayerG.pBulletCount[collisionBody.playerIndex] -=1
			AudioG.playSFX2("bulletCollide",true)
		
		
		velocity = velocity.bounce(collision.get_normal())
		
		
	if collisionBody != null and collisionBody.name == "Walls":
		AudioG.playSFX("bulletBounce",true)
	
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
			if isAI && isCampaign: return
			PlayerG.PlayerScore[playerIndex]["game score"] -= 1
			#region team score
			var total = 0
			for color in PlayerG.activeTankColor:
				if PlayerG.activeTankColor[color] == PlayerG.activeTankColor[playerIndex]: total += 1
			if total == 1: PlayerG.teamScore[PlayerG.activeTankColor[playerIndex]] -=1
			if PlayerG.teamScore[PlayerG.activeTankColor[playerIndex]] < 0: PlayerG.teamScore[PlayerG.activeTankColor[playerIndex]] = 0
			#endregion team score
			if PlayerG.PlayerScore[playerIndex]["game score"] < 0: PlayerG.PlayerScore[playerIndex]["game score"] = 0
		
			PlayerG.PlayerScore[playerIndex]["suicide"] += 1
		else: #if the bullet has hit a player other than the sender
			if isAI && isCampaign: return
			PlayerG.PlayerScore[playerIndex]["kills"] += 1
			PlayerG.PlayerScore[playerIndex]["game score"] += 1
			if isCampaign:
				if body.isAI: StoryManager.livesNode.rescueTanks()
				return
				
			if !PlayerG.activeTankColor[body.playerIndex] == PlayerG.activeTankColor[playerIndex]: PlayerG.teamScore[PlayerG.activeTankColor[playerIndex]] +=1 #team score
			if PlayerG.isSurvival && !PlayerG.isAI[playerIndex]: PlayerG.SURVIVALKill()
		if GameManager.Debug: print("Player ", playerIndex, "'s score is: ", PlayerG.PlayerScore[playerIndex])
