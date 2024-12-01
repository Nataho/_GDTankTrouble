extends Node

var playerRotation:int
var playerVelocity
@export_range(0,10,1) var respawnTime: int

#region Multiplayer
var playerAmount:int = 0 #counts the amount of players t
var EnableKeyboard: bool = false

#games
var FFA_TimeLimit:int = 120 #120 is the default
var gameFinished:bool = false

var ActivePlayers:Array = [] #stores players that are active
#endregion Multiplayer

#default settings
###############
#window size (2560,1440)

###############

#region tutorial
var PlayerRotated = false
var PlayerMoved = false
var PlayerShot = false
#endregion

#region kiosk
var kiosk_gameNum = 0
#endregion kiosk

var bulletCap = 5

var PlayerScore = {
	-1 : {"kills":0, "deaths": 0, "suicide":0, "game score":0, "total score":0, "flag score": 0, "friendly fire": 0},
	0 : {"kills":0, "deaths": 0, "suicide":0, "game score":0, "total score":0, "flag score": 0, "friendly fire": 0},
	1 : {"kills":0, "deaths": 0, "suicide":0, "game score":0, "total score":0, "flag score": 0, "friendly fire": 0},
	2 : {"kills":0, "deaths": 0, "suicide":0, "game score":0, "total score":0, "flag score": 0, "friendly fire": 0},
	3 : {"kills":0, "deaths": 0, "suicide":0, "game score":0, "total score":0, "flag score": 0, "friendly fire": 0},
	4 : {"kills":0, "deaths": 0, "suicide":0, "game score":0, "total score":0, "flag score": 0, "friendly fire": 0},
	5 : {"kills":0, "deaths": 0, "suicide":0, "game score":0, "total score":0, "flag score": 0, "friendly fire": 0},
	6 : {"kills":0, "deaths": 0, "suicide":0, "game score":0, "total score":0, "flag score": 0, "friendly fire": 0},
	7 : {"kills":0, "deaths": 0, "suicide":0, "game score":0, "total score":0, "flag score": 0, "friendly fire": 0},
}

var playerNames = {
	-1: "keyboard",
	0: "Player 1",
	1: "Player 2",
	2: "Player 3",
	3: "Player 4",
	4: "Player 5",
	5: "Player 6",
	6: "Player 7",
	7: "Player 8",
}

var pBulletCount = { #counts bullets of players
	-1: 0,
	0: 0,
	1: 0,
	2: 0,
	3: 0,
	4: 0,
	5: 0,
	6: 0,
	7: 0,
}

#takes forward vector of players for shooting velocity
var playerForwardV = [
	Vector2(),
	Vector2(),
	Vector2(),
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
	false,
	false,
	false,
]

#region colors of players
var tankColor = {
	-1: Color(2,2,2,1), #(1, 2, -.10, 1), #keyboard and mouse
	0: Color(1,2,3,1), #controller 1 (1121)
	1: Color(4,1,1,1), #controller 2
	2: Color(1.05,2.76,1.82,1), #controller 3
	3: Color(3,2,1,1), #controller 4
	4: Color(1,1,2,1),
	#5: Color(1.98, 1.09, -0.26, 1), #original orange
	5: Color(2.943, 1.82, 1.21, 1), #orange
	#6: Color(1.68, 1.83, 2.74, 1), #original purple
	6: Color(2, 1, 2.42, 1), #purple
	7: Color(2.66, 1.78, 2.54, 1),
}


var activeTankColor = {
	#0: Color(1.98, 1.09, -0.26, 1)
} #stores new tank colors
#endregion

var isAI = {
	-1: false,
	0: false,
	1: false,
	2: false,
	3: false,
	4: false,
	5: false,
	6: false,
	7: false,
}

var EnemyTankColor := [
	Color(1,2,2,1),#sky blue
	Color(1,2,1,1), #green
	Color(1.94, 0.11, 0.59,1), #dark_pink
]

func reset():
	playerAmount = 0 #counts the amount of players to be spawned
	FFA_TimeLimit = 120
	gameFinished = false
	PlayerRotated = false
	PlayerMoved = false
	PlayerShot = false
	
	kiosk_gameNum = 0
	
	ActivePlayers = []
	
	PlayerScore = {
		-1 : {"kills":0, "deaths": 0, "suicide":0, "game score":0, "total score":0, "flag score": 0, "friendly fire": 0},
		0 : {"kills":0, "deaths": 0, "suicide":0, "game score":0, "total score":0, "flag score": 0, "friendly fire": 0},
		1 : {"kills":0, "deaths": 0, "suicide":0, "game score":0, "total score":0, "flag score": 0, "friendly fire": 0},
		2 : {"kills":0, "deaths": 0, "suicide":0, "game score":0, "total score":0, "flag score": 0, "friendly fire": 0},
		3 : {"kills":0, "deaths": 0, "suicide":0, "game score":0, "total score":0, "flag score": 0, "friendly fire": 0},
		4 : {"kills":0, "deaths": 0, "suicide":0, "game score":0, "total score":0, "flag score": 0, "friendly fire": 0},
		5 : {"kills":0, "deaths": 0, "suicide":0, "game score":0, "total score":0, "flag score": 0, "friendly fire": 0},
		6 : {"kills":0, "deaths": 0, "suicide":0, "game score":0, "total score":0, "flag score": 0, "friendly fire": 0},
		7 : {"kills":0, "deaths": 0, "suicide":0, "game score":0, "total score":0, "flag score": 0, "friendly fire": 0},
	}
	playerNames = {
		-1: "keyboard",
		0: "Player 1",
		1: "Player 2",
		2: "Player 3",
		3: "Player 4",
		4: "Player 5",
		5: "Player 6",
		6: "Player 7",
		7: "Player 8",
	}
	pBulletCount = { #counts bullets of players
		-1: 0,
		0: 0,
		1: 0,
		2: 0,
		3: 0,
		4: 0,
		5: 0,
		6: 0,
		7: 0,
	}
	playerForwardV = [
		Vector2(),
		Vector2(),
		Vector2(),
		Vector2(),
		Vector2(),
		Vector2(),
		Vector2(),
		Vector2(),
	]
	playerPower = [
		false,
		false,
		false,
		false,
		false,
		false,
		false,
		false,
	]
	
	#tankColor = {
		#-1: Color(2,2,2,1), #(1, 2, -.10, 1), #keyboard and mouse
		#0: Color(1,2,3,1), #controller 1 (1121)
		#1: Color(4,1,1,1), #controller 2
		#2: Color(1,2,1,1), #controller 3
		#3: Color(3,2,1,1), #controller 4
		#4: Color.BLUE,
		#5: Color.PURPLE,
		#6: Color.ORANGE,
		#7: Color.DEEP_PINK,
	#}
	
	isAI = {
		-1: false,
		0: false,
		1: false,
		2: false,
		3: false,
		4: false,
		5: false,
		6: false,
		7: false,
	}
	
	if GameManager.Debug: print(isAI)
