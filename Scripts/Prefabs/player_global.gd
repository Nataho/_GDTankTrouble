extends Node

var playerRotation:int
var playerVelocity
@export_range(0,10,1) var respawnTime: int

var bulletCap = 5
var pBulletCount = { #counts bullets of players
	-1: 0,
	0: 0,
	1: 0,
	2: 0,
	3: 0,
}
#takes forward vector of players for shooting velocity
var playerForwardV = [
	Vector2(),
	Vector2(),
	Vector2(),
	Vector2(),
	Vector2(),
]

#powerup of players
var playerPower = [
	false,
	false,
	false,
	false,
	false,
]

#colors of players
var tankColor = {
	-1: Color(1,1,1,1), #keyboard and mouse
	0: Color(1,1,2,1), #controller 1
	1: Color(4,1,1,1), #controller 2
	2: Color(2,2,1,1), #controller 3
	3: Color(3,2,1,1), #controller 4
}

var EnemyTankColor := [
	Color(1,2,3,1), #sky blue
]





func reset():
	PlayerG.pBulletCount = { #counts bullets of players
	-1: 0,
	0: 0,
	1: 0,
	2: 0,
	3: 0,
}
###########
	playerForwardV = [
	Vector2(),
	Vector2(),
	Vector2(),
	Vector2(),
	Vector2(),
]
###########
	playerPower = [
	false,
	false,
	false,
	false,
	false,
]
