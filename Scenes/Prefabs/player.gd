extends CharacterBody2D
class_name Player
const isPlayer = true

#region AI
@export var isAI:bool = false
@export var canRespawn = true
#endregion

#region campaign
@export var isCampaign = false
#endregion campaign
var tankParent
var SPEED = 150; const defaultSPEED = 150
var rotationSPEED = 3.0; const defaultRotationSPEED = 3.0
var SPEEDmultiplier = 1

@export_range(-1,7,0.1) var playerIndex := 0 #for the player controls of a controller
var bulletCount:int = PlayerG.PlayerBulletCap[playerIndex] #cap for the bullet, asked in player_global.gd
@export_range(0,10,0.1) var drag_factor := 0.1# ??
@export var tankScale = 1; const Scale_default = 5
@export var isTutorial = false
@export var isPlayerMenu = false
@export var canShoot_Move = true
var canShoot = true

@onready var head_power: Sprite2D = $power/HeadPower
@onready var pathFinder: NavigationAgent2D = $NavigationAgent2D


var velo: Vector2 = Vector2.ZERO
var plBullet := preload("res://Scenes/Prefabs/bullet.tscn")

var Spawned = false
var CoastClear = false
var raycastTarget = false
var targetDirection = rotation_degrees

var defaultModulate = 1
var allModulate = defaultModulate
func _process(delta: float) -> void:
	
	while allModulate > defaultModulate:
		allModulate -= 0.001
		modulate = Color(allModulate,allModulate,allModulate)
		await get_tree().create_timer(0.01).timeout
		if allModulate < defaultModulate: allModulate = defaultModulate
		
	if isPlayerMenu: modulate = Color.LIGHT_GOLDENROD; $power/WorldEnvironment.environment = null
	if GameManager.Debug: if Input.is_action_just_pressed("goBack"): get_tree().quit()
	
	#######inputs
	UIcontrols()

#region aditional controls
signal interacting
var pressing = false
func UIcontrols():
	if Input.is_action_just_pressed("interact"): interact()
	if Input.is_joy_button_pressed(playerIndex,JOY_BUTTON_Y) and !StoryManager.isDialogue: 
		if not pressing:
			pressing = true
			interact()
	elif Input.is_joy_button_pressed(playerIndex,JOY_BUTTON_A):
		if not pressing:
			pressing = true
			interact()
	else: pressing = false
func interact():
	interacting.emit()
	
	if GameManager.currentFocus is Button: GameManager.currentFocus.emit_signal("pressed")
#endregion aditional controls
#region startup
func _ready():
	bulletCount = PlayerG.PlayerBulletCap[playerIndex]
	if GameManager.isIdle || PlayerG.isHardMode: 
		$Vision.monitoring = true
		$Vision2.monitoring = false
	else:
		$Vision.monitoring = false #turn true if hard mode
		$Vision2.monitoring = true
	
	if PlayerG.isSurvival && !isAI: allModulate = 5
	if get_parent().get_parent(): tankParent = get_parent().get_parent()
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
	if isAI: set_AI_detection(true)
	
#endregion startup

func Died():
	if tankParent && !isAI && PlayerG.isSurvival:
		tankParent.died()
	
	power_reset()
	self.hide() #hide player
	self.set_process_mode(4) #process of player is disabled
	$Timer.start() #start respawn timer
	idle()
	

func Respawn():
	#print("respawning")
	if !canRespawn: return
	if isCampaign:
		
		print("respawning")
		show() #hide player
		set_process_mode(0)
		$Timer.stop()
		return
	
	power_reset()
	tankScale = 1
	scale = Vector2(tankScale*Scale_default, tankScale*Scale_default)
	
	CHECK()

func CHECK():
	#region stop respawn
	if isTutorial: return #tutorial
	if isPlayerMenu: return #player menu
	if isCampaign: return #campaign
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
	if PlayerG.isSurvival && !isAI: allModulate = 5
	
	set_collision_layer_value(32,false) ; $invincibility.start()
	

func _physics_process(delta):
	if PlayerG.gameFinished: return
	
	if !isAI:
		#region pathfinding
		
		#endregion pathfinding
		if StoryManager.isDialogue: return
		#print(StoryManager.isDialogue)
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
	
	
	if playerIndex == -1: 
		rotate = Input.get_action_strength("rotate right") - Input.get_action_strength("rotate left")
		
		
	else: 
		rotate = Input.get_joy_axis(playerIndex,2)
		
		
	#region Controller
	#if Input.is_joy_button_pressed(playerIndex,JOY_BUTTON_B):
		#rotate = 1
		#
	#elif Input.is_joy_button_pressed(playerIndex,JOY_BUTTON_X):
		#rotate = -1
	if playerIndex != -1:
		var joyAxis: Vector2
		joyAxis.x = Input.get_joy_axis(playerIndex,JOY_AXIS_LEFT_X)
		joyAxis.y = Input.get_joy_axis(playerIndex,JOY_AXIS_LEFT_Y)
		
		var deadZone = 0.1
		if joyAxis.x > -deadZone && joyAxis.x < deadZone && joyAxis.y > -deadZone && joyAxis.y < deadZone: return
		
		var angleInRadians := atan2(joyAxis.y, joyAxis.x)
		var angleInDegrees = rad_to_deg(angleInRadians)
		
		var angleDifference = wrapf(angleInDegrees - rotation_degrees, -180, 180)
		
		if angleDifference > 1.5: rotate = 1
		elif angleDifference < -1.5: rotate = -1
		else: rotate = 0
		
	#endregion Controller
		
	if rotate<-0.1 or rotate>0.1:
		rotation_degrees += rotate * rotationSPEED * SPEEDmultiplier; PlayerG.PlayerRotated = true
		if isIdle: 
			isIdle = false
		#print("asdf")
		$Idle.start()
		idle_remove()
		emit_signal("moved",self)
		#print("emitting moved")
		hasMoved = true#;print("emitting moved")
		

var desired_velocity := Vector2.ZERO
var steering_velocity := Vector2.ZERO
var moving = false
var moveJoy:Vector2 = Vector2.ZERO
func Movement(delta):
	
	#region stop movement
	if !canShoot_Move: return #player menu
	#endregion

	forward_vector = (Vector2(cos(-rotation), sin(rotation)))
	if playerIndex == -1: 
		move = Input.get_action_strength("forward") - Input.get_action_strength("back");
	else: 
		#move = Input.get_joy_axis(playerIndex,1)*-1;
		if Input.is_joy_button_pressed(playerIndex,JOY_BUTTON_A):
			moveJoy.x = 1
		else: moveJoy.x = 0
		if Input.is_joy_button_pressed(playerIndex,JOY_BUTTON_B):
			moveJoy.y = 1
		else: moveJoy.y = 0
		
		move = moveJoy.x - moveJoy.y
		
	if move<-0.1 or move>0.1:
		velocity = forward_vector * move * SPEED * SPEEDmultiplier; PlayerG.PlayerMoved = true
		if isIdle: 
			isIdle = false
		#print("asdf")
		$Idle.start()
		idle_remove()
		emit_signal("moved",self)
		#print("emitting moved")
		hasMoved = true#;print("emitting moved")
			

		
	else:
		velocity = Vector2.ZERO
	#PlayerG.playerForwardV[playerIndex] = forward_vector #default
	PlayerG.playerForwardV[playerIndex] = forward_vector
	PlayerG.playerForwardV10[playerIndex] = -(Vector2(cos(rotation+3), sin(rotation+3)))
	PlayerG.playerForwardV_10[playerIndex] = -(Vector2(cos(rotation-3), sin(rotation-3)))
	translate(velocity * delta)  
	move_and_slide() 
	
#region shooting dw
var hasShot = false #prevents shooting multiple bullets when pressing one button
func Shoot():
	#region stopShooting 
	if !canShoot_Move: return #player menu
	if !canShoot: return
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
				bullet.spawnRot = rotation
				bullet.isCampaign = isCampaign
				add_child(bullet); bullet.reparent(get_parent())
				if GameManager.Debug: print("SHOOT")
				
			if isMultishot:
				var extraBullets = 0
				while extraBullets < 2:
					if PlayerG.pBulletCount[playerIndex] >= bulletCount: return
					var bullet = plBullet.instantiate()
					bullet.isMultiShot = true
					bullet.multiShotCount = extraBullets
					if extraBullets == 0: 
						bullet.position += Vector2(15,-5)
						bullet.spawnRot = rotation
						
						
					else: 
						bullet.position += Vector2(15,5)
						bullet.spawnRot = rotation
					
					bullet.isCampaign = isCampaign
					add_child(bullet); bullet.reparent(get_parent())
					extraBullets += 1
					#if GameManager.Debug: print("SHOOT")
				
				
	else:
		if Input.is_joy_button_pressed(playerIndex,JOY_BUTTON_X) or Input.is_joy_button_pressed(playerIndex,JOY_BUTTON_RIGHT_SHOULDER):# or Input.is_action_just_pressed("shoot"): #presses RB / R1 / R
			if hasShot: return
			if !hasShot:
				if GameManager.Debug: print(hasShot)
				var bullet = plBullet.instantiate()
				bullet.position.x += 15
				bullet.isCampaign = isCampaign
				add_child(bullet); bullet.reparent(get_parent())
				if GameManager.Debug: print("SHOOT")
				hasShot = true
				
			if isMultishot:
				#if hasShot: return
				var extraBullets = 0
				while extraBullets < 2:
					if PlayerG.pBulletCount[playerIndex] >= bulletCount: return
					var bullet = plBullet.instantiate()
					bullet.isMultiShot = true
					bullet.multiShotCount = extraBullets
					if extraBullets == 0: 
						bullet.position += Vector2(15,-5)
						bullet.spawnRot = rotation
						
					else: 
						bullet.position += Vector2(15,5)
						bullet.spawnRot = rotation
					bullet.isCampaign = isCampaign
					
					add_child(bullet); bullet.reparent(get_parent())
					extraBullets += 1
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


#region AI(randomized)
const crum = false 

func initializeAI():
	$AI/Shoot.start()
	$AI/Rotation.start()
	$AI/Movement.start()

var doRotation = false
var rotate = 0
var ignoreState = false
func AI_Rotate():
	$AI/Rotation.wait_time = randf_range(0.1,1)
	
	doRotation = randi_range(1,0) == 1 #true or false
	ignoreState = randi_range(1,0) == 1 #true or false
	if state: return
	rotate = randf_range(-1,1)

var move = 0
var forward_vector
var doMovement = false
func AI_Move():
	$AI/Movement.wait_time = randf_range(0.1,1)
	move = randf_range(-1,1)
	doMovement = randi_range(1,0) == 1 #true or false

func AI_Shoot():
	if !state || $CheckWall.is_colliding(): return
	if blocked: return
	
	if isMultishot:
		var extraBullets = 0
		while extraBullets < 2:
			if PlayerG.pBulletCount[playerIndex] >= bulletCount: return
			var multiBullet = plBullet.instantiate()
			multiBullet.isMultiShot = true
			multiBullet.multiShotCount = extraBullets
			if extraBullets == 0: 
				multiBullet.position += Vector2(15,-5)
				multiBullet.spawnRot = rotation
				
			else: 
				multiBullet.position += Vector2(15,5)
				multiBullet.spawnRot = rotation
			
			add_child(multiBullet); multiBullet.reparent(get_parent())
			extraBullets += 1
	
	$AI/Shoot.wait_time = randf_range(0.1,5)
	var bullet = plBullet.instantiate()
	bullet.position.x += 15
	bullet.playerIndex = playerIndex
	add_child(bullet); bullet.reparent(get_parent())
	
	
	if GameManager.Debug: print("SHOOT")

func AIdoRotation():
	
	if state && doRotation && !ignoreState:
		#var direction = ($Vision.to_local(target.position) - position).normalized()
		#var targetAngle = rad_to_deg(atan2(direction.y, direction.x))
		#var angleDiff = wrapf(targetAngle - rotation, -180, 180)
		if targetDirection < rotation_degrees: rotate = -1
		elif targetDirection > rotation_degrees: rotate = 1
		if abs(rotation_degrees - targetDirection) < 1: rotate = 0
		
		self.rotation_degrees += rotate * rotationSPEED * SPEEDmultiplier
		
	elif doRotation:
		self.rotation_degrees += rotate * rotationSPEED * SPEEDmultiplier
func AIdoMovement(delta):
	#PlayerG.playerForwardV[playerIndex] = forward_vector #defautl
	PlayerG.playerForwardV[playerIndex] = forward_vector
	#forward_vector = (Vector2(cos(-rotation), sin(rotation))) #default
	forward_vector = (Vector2(cos(-rotation), sin(rotation)))
	
	PlayerG.playerForwardV10[playerIndex] = -(Vector2(cos(rotation+3), sin(rotation+3)))
	PlayerG.playerForwardV_10[playerIndex] = -(Vector2(cos(rotation-3), sin(rotation-3)))
	if doMovement:
		velocity = forward_vector * move * SPEED * SPEEDmultiplier; PlayerG.PlayerMoved = true
		translate(velocity * delta)
		move_and_slide()


@onready var vision: Area2D = $Vision

##########################
var target = null
#var states = {
	#"found" : true
#}
var targetDetails = {
	"position" = Vector2(),
	
}
var state
var powerFound

func AI_player_in_area(body):
	if !isAI: return
	#print(self.name, " HAS FOUND ", body.name)
	
	#if body == self: return
	if !body.crum: if PlayerG.activeTankColor[playerIndex] == PlayerG.activeTankColor[body.playerIndex]: return
	if !(body not in get_tree().get_nodes_in_group("Player") || body.name == self.name || state):
		$MeshInstance2D.show()
		target = body
		targetDetails["position"] = body.position
		state = true
		#print(self.name, " HAS FOUND ", body.name)
		doRotation = true
		ignoreState = false
		$AI/Rotation.wait_time = 2; $AI/Rotation.start()
	
	if body.crum: 
		target = body
		state = true
		doRotation = true
		ignoreState = false
	#if !(state): 
		#target = body
		#state = true
		#powerFound = true
		#print(self.name, " HAS FOUND ", body.name)
	
	
	#look_at(body.position) #not good
	

func AI_player_out_area(body):
	if !isAI: return
	if !(body != target || body.name == self.name):
		$MeshInstance2D.hide()
		#print(self.name, " HAS LOST ", body.name)
		target = null
		targetDetails["position"] = Vector2()
		state = false
		
	if body.crum: 
		target = null
		state = false
		#AIcanShoot = false
		doRotation = true
		ignoreState = false
	#if !(state): 
		#print(self.name, " HAS LOST ", body.name)
		#
		#target = null
		#state = false
		#powerFound = false

func breadCrum():
	var crum = load("res://Scenes/MainScenes/crum.tscn")
	crum.position = Vector2(0,50)
	add_child(crum)
	
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
	set_multi_shot(false)
	
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
		while tankScale < value and scaling: #runs when value is	 higher than current scale
			tankScale += 0.1
			if tankScale > value:
				tankScale = value
			scale = Vector2(tankScale * Scale_default, tankScale * Scale_default)
			await get_tree().create_timer(0.01).timeout  # Small delay to slow down the loop

func invincibility():
	set_collision_layer_value(32,true)
	
func set_tank_speed(value) -> void:
	if value > 3: value = 3
	elif value < 0.5: value = 0.5
	if value < SPEEDmultiplier: pass #runs when tank speed is lower than current scale
	
	SPEEDmultiplier = value

var isMultishot:bool = false
func set_multi_shot(enabled):
	if enabled: 
		bulletCount = 9
	else: bulletCount = 5
	isMultishot = enabled
	

func set_tank_power_color(value:Color):
	head_power.modulate = value
#endregion Setters
#endregion PowerUps


#region timed looping functions
var isAID #is AI Detection
func set_AI_detection(value:bool):
	isAID = value
	if isAID: AI_Detection()
func AI_Detection():
	if isAI && state: 
		#var targetPos = $Vision.to_local(target.position)
		#$RayCast2D.target_position = targetPos
		#$eye.look_at(targetPos)
		
		$eye.rotation_degrees = 0
		$RayCast2D.target_position = $Vision.to_local(target.position)
		$eye.look_at(target.position)
		targetDirection = $eye.global_rotation_degrees
		#print("Player direction ",targetDirection)wd
		#print("bot rotation ",rotation_degrees)
	else:$RayCast2D.target_position = Vector2(100,0)
	await get_tree().create_timer(0.1).timeout
	if isAID: AI_Detection()
#endregion timed looping functions

#region Idle
var isIdle = true
var hasMoved
signal moved
signal IdleEntered
signal IdleExited(PlayerBody:Player)
@onready var idleTimer: Timer = $Idle

func idle():
	if !hasMoved: return
	if isIdle: return
	
	isIdle = true
	emit_signal("IdleEntered",self)
	$Idle.stop()

func idle_remove():
	emit_signal("IdleExited",self)
	isIdle = false
	#$Idle.start()
#endregion Idle
