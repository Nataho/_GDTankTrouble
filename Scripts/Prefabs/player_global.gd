extends Node

var playerRotation:int
var playerVelocity

var bulletCap = 10
var pBulletCount = { #counts bullets of players
	0: 0,
	1: 0,
	2: 0,
	3: 0,
	4: 0,
}
var playerForwardV = [
	Vector2(),
	Vector2(),
	Vector2(),
	Vector2(),
	Vector2(),
]
var playerPower = [
	false,
	false,
	false,
	false,
	false,
]

var tankColor = {
	0: Color(1,1,2,1),
	1: Color(2,1,1,1),
	2: Color(2,2,1,1),
	3: Color(3,2,1,1),
	4: Color(1,1,1,1),
}





func reset():
	PlayerG.pBulletCount = { #counts bullets of players
	0: 0,
	1: 0,
	2: 0,
	3: 0,
	4: 0,
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
