extends CharacterBody2D

#region AI
@export var isAI:bool = false
#endregion

var SPEED = 150; const defaultSPEED = 150
var rotationSPEED = 3.0; const defaultRotationSPEED = 3.0
var SPEEDmultiplier = 1

@export_range(-1,7,0.1) var playerIndex := 0 #for the player controls of a controller
var bulletCount = PlayerG.bulletCap #cap for the bullet, asked in player_global.gd
@export_range(0,10,0.1) var drag_factor := 0.1# ??
@export var tankScale = 1; const Scale_default = 5
@export var isTutorial = false
@export var isPlayerMenu = false
@export var canShoot_Move = true

@onready var head_power: Sprite2D = $power/HeadPower

var velo: Vector2 = Vector2.ZERO
var plBullet := preload("res://Scenes/Prefabs/bullet.tscn")

var Spawned = false
var CoastClear = false

func _process(delta: float) -> void:
	if isPlayerMenu: modulate = Color.LIGHT_GOLDENROD; $power/WorldEnvironment.environment = null
	if GameManager.Debug: if Input.is_action_just_pressed("goBack"): get_tree().quit()
#region startup
func _ready():
	if isTutorial: PlayerG.activeTankColor[playerIndex] = PlayerG.tankColor[playerIndex]
	
	if GameManager.Debug:
		if playerIndex == -1:
			PlayerG.activeTankColor[playerIndex] = PlayerG.tankColor[playerIndex]
			
			#tankScale = 0.5
		#var camera = Camera2D.new()
		#add_child(camera)
		#camera.zoom = Vector2(3,3)
	
	if !isPlayerMenu: scale = Vector2(tankScale*Scale_default,tankScale*Scale_default)
	
	CheckAI()
	$Timer.wait_time = PlayerG.respawnTime
	if !isPlayerMenu: 
		if playerIndex in PlayerG.activeTankColor:
			var color = PlayerG.activeTankColor[playerIndex]
			#modulate = color
			
			$Body.modulate = Color(color.r * 0.43, color.g * 0.43, color.b * 0.43, color.a)
			$Nozzle.modulate = Color(color.r * 0.25, color.g * 0.25, color.b * 0.25, color.a)
			$Head.modulate = Color(color.r * 0.33, color.g * 0.33, color.b * 0.33, color.a)
		else: modulate = PlayerG.tankColor[playerIndex]
	CHECK()

func CheckAI():
	isAI = PlayerG.isAI[playerIndex]
	if isAI: print("player AI index ", playerIndex,"; isAI: ", isAI)
	if isAI: initializeAI()
#endregion startup
func Died():
	self.hide() #hide player
	self.set_process_mode(4) #process of player is disabled
	$Timer.start() #start respawn timer
	

func Respawn():
	power_reset()
	tankScale = 1
	scale = Vector2(tankScale*Scale_default, tankScale*Scale_default)
	
	CHECK()

func CHECK():
	#region stop respawn
	if isTutorial: return #tutorial
	if isPlayerMenu: return #player menu
	#endregion
	
	var respawnAttempts = 0
	self.show()
	self.set_process_mode(0)
	var WindowSize = Vector2(2560,1440) #get_viewport().size
	while !Spawned:
		randomize()
		CoastClear = true
		var screenEdge = 50
		var rngX = randi_range(screenEdge, WindowSize.x -screenEdge)
		var rngY = randi_range(screenEdge, WindowSize.y -screenEdge)
		var rngRot = randi_range(0,360)
		self.rotation_degrees = rngRot
		self.position = Vector2(rngX,rngY)

		#check for nearby players and walls
		for body in get_tree().get_nodes_in_group("Player"):
			if body != self and self.position.distance_to(body.position) < 475 :
				CoastClear = false; respawnAttempts +=1
				break

		for body in get_tree().get_nodes_in_group("Walls"):
			if body != self and self.position.distance_to(body.position) < 150:
				CoastClear = false; respawnAttempts +=1
				break
		
		#if body != self and self

		for body in get_tree().get_nodes_in_group("bullet"):
			if body != self and self.position.distance_to(body.position) < 150:
				CoastClear = false; respawnAttempts +=1
				print("This Player is near a bullet and can't spawn")
				break
				
		if CoastClear:
			if GameManager.Debug: print("This Player Can Now Spawn!")
			if GameManager.Debug: print(self.name, " spawn attempts: " , respawnAttempts)
			Spawned = true
			break
		else:
			if GameManager.Debug: print("Check Failed, Relocating; ", respawnAttempts)
		

func _physics_process(delta):
	
	if PlayerG.gameFinished: return
	if !isAI:
		Rotation()
		POWER()
		Movement(delta)
		Shoot()
	elif isAI:
		AIdoRotation()
		AIdoMovement(delta)
	
	

var hasPressedPower = false
func POWER():
	if playerIndex == -1: 
		if Input.is_action_just_pressed("RemoteMissile"):
			if !hasPressedPower:
				hasPressedPower = true
				PlayerG.playerPower[playerIndex] = !PlayerG.playerPower[playerIndex]
				#print(PlayerG.playerPower[playerIndex])
		else: hasPressedPower = false
	else: 
		if Input.is_joy_button_pressed(playerIndex,9):
			if !hasPressedPower:
				hasPressedPower = true
				PlayerG.playerPower[playerIndex] = !PlayerG.playerPower[playerIndex]
				#print(PlayerG.playerPower[playerIndex])
		else: hasPressedPower = false
	
	#if PlayerG.playerPower[playerIndex]:
		#$HeadPower.show()
	#else:
		#$HeadPower.hide()

func Rotation():
	
	#region stop rotation
	#if isPlayerMenu: return #player menu
	#endregion
	
	
	if playerIndex == -1: rotate = Input.get_action_strength("rotate right") - Input.get_action_strength("rotate left")
	else: rotate = Input.get_joy_axis(playerIndex,2)
	
	if Input.is_joy_button_pressed(playerIndex,JOY_BUTTON_B):
		rotate = 1
	elif Input.is_joy_button_pressed(playerIndex,JOY_BUTTON_X):
		rotate = -1
		
	if rotate<-0.1 or rotate>0.1:
		rotation_degrees += rotate * rotationSPEED * SPEEDmultiplier; PlayerG.PlayerRotated = true

var desired_velocity := Vector2.ZERO
var steering_velocity := Vector2.ZERO
func Movement(delta):
	
	#region stop movement
	if !canShoot_Move: return #player menu
	#endregion
	#var direction = Input.get_vector('rotate left','rotate right','forward','back')
	#desired_velocity = direction * SPEED
	#steering_velocity = desired_velocity - velocity
	#velocity += steering_velocity * drag_factor
	#velocity = direction * SPEED
	#rotation = velocity.angle()
	
	#look_at(get_global_mouse_position())
	forward_vector = (Vector2(cos(-rotation), sin(rotation)))
	if playerIndex == -1: move = Input.get_action_strength("forward") - Input.get_action_strength("back");
	else: move = Input.get_joy_axis(playerIndex,1)*-1;
	if move<-0.1 or move>0.1:
		velocity = forward_vector * move * SPEED * SPEEDmultiplier; PlayerG.PlayerMoved = true
	else:
		velocity = Vector2.ZERO
	PlayerG.playerForwardV[playerIndex] = forward_vector
	translate(velocity * delta)
	move_and_slide()
	
#region shooting
var hasShot = false #prevents shooting multiple bullets when pressing one button
func Shoot():
	#region stopShooting
	if !canShoot_Move: return #player menu
	#endregion
	
	#region tutorial
	if blocked: return
	if isTutorial:
		PlayerG.PlayerShot = true #for tutorial
	#endregion
	#group
	if PlayerG.pBulletCount[playerIndex] >= bulletCount: return
	if playerIndex == -1: 
		if Input.is_action_just_pressed("shoot"):
			if !hasShot:
				var bullet = plBullet.instantiate()
				bullet.position.x += 15
				add_child(bullet); bullet.reparent(get_parent())
				if GameManager.Debug: print("SHOOT")
	else:
		if Input.is_joy_button_pressed(playerIndex,JOY_BUTTON_A) or Input.is_joy_button_pressed(playerIndex,JOY_BUTTON_RIGHT_SHOULDER):# or Input.is_action_just_pressed("shoot"): #presses RB / R1 / R
			if !hasShot:
				if GameManager.Debug: print(hasShot)
				var bullet = plBullet.instantiate()
				bullet.position.x += 15
				add_child(bullet); bullet.reparent(get_parent())
				if GameManager.Debug: print("SHOOT")
				hasShot = true
		else: hasShot = false;#print(hasShot)
#endregion
func CheckForWalls(body): #area2d
	if body.name != self.name and not Spawned:
		if GameManager.Debug: print(self.name + " you are near a wall " + body.name)
		CoastClear = false
func CheckForPlayers(body): #area2d
	if body.name != self.name and !Spawned:
		if GameManager.Debug: print(self.name + " you are near " + body.name)
	elif body.name == self.name: CoastClear = true

#region nozzle check
var blocked:bool = false
func CheckForBlockage(body): 
	if body.name == "Walls":
		blocked = true
	else: return
func CheckForPassage(body): 
	if body.name == "Walls": blocked = false
	else: return
#endregion


#region AI(randomized0
func initializeAI():
	$AI/Shoot.start()
	$AI/Rotation.start()
	$AI/Movement.start()

var doRotation = false
var rotate
func AI_Rotate():
	$AI/Rotation.wait_time = randf_range(0.1,1)
	rotate = randf_range(-1,1)
	doRotation = randi_range(1,0) == 1 #true or false

var move
var forward_vector
var doMovement = false
func AI_Move():
	$AI/Movement.wait_time = randf_range(0.1,1)
	move = randf_range(-1,1)
	doMovement = randi_range(1,0) == 1 #true or false

func AI_Shoot():
	if blocked: return
	$AI/Shoot.wait_time = randf_range(0.1,5)
	var bullet = plBullet.instantiate()
	bullet.position.x += 15
	bullet.playerIndex = playerIndex
	add_child(bullet); bullet.reparent(get_parent())
	if GameManager.Debug: print("SHOOT")

func AIdoRotation():
	if doRotation:
		self.rotation_degrees += rotate * rotationSPEED * SPEEDmultiplier
		
func AIdoMovement(delta):
	PlayerG.playerForwardV[playerIndex] = forward_vector
	forward_vector = (Vector2(cos(-rotation), sin(rotation)))
	if doMovement:
		velocity = forward_vector * move * SPEED * SPEEDmultiplier; PlayerG.PlayerMoved = true
		translate(velocity * delta)
		move_and_slide()
#endregion

#region PowerUps
func start_power_timer(value):
	head_power.show()
	$powerTimer.wait_time = value
	$powerTimer.start()

func stop_power_timer():
	$powerTimer.stop()
	power_reset()

func power_reset():
	head_power.hide()
	scaling = false
	set_tank_scale(1)
	set_tank_speed(1)
	
#region Setters
#for tank scale powerups
var scaling = true
func set_tank_scale(value) -> void:
	scaling = true
	if value < tankScale: #runs when value is lower than current scale
		while tankScale > value and scaling:
			tankScale -= 0.1
			if tankScale < value:
				tankScale = value
			scale = Vector2(tankScale * Scale_default, tankScale * Scale_default)
			await get_tree().create_timer(0.01).timeout  # Small delay to slow down the loop
	else:
		while tankScale < value and scaling: #runs when value is higher than current scale
			tankScale += 0.1
			if tankScale > value:
				tankScale = value
			scale = Vector2(tankScale * Scale_default, tankScale * Scale_default)
			await get_tree().create_timer(0.01).timeout  # Small delay to slow down the loop


func set_tank_speed(value) -> void:
	if value > 3: value = 3
	elif value < 0.5: value = 0.5
	if value < SPEEDmultiplier: pass #runs when tank speed is lower than current scale
	SPEEDmultiplier = value

func set_tank_power_color(value:Color):
	head_power.modulate = value
#endregion Setters
#endregion PowerUps
