extends CharacterBody2D

const SPEED = 150
const rotationSPEED = 5.0

@export_range(0,4,0.1) var playerIndex := 0
var bulletCount = PlayerG.bulletCap
@export_range(0,10,0.1) var drag_factor := 0.1

var velo: Vector2 = Vector2.ZERO
var plBullet := preload("res://Scenes/Prefabs/bullet.tscn")

func _ready():
	modulate = PlayerG.tankColor[playerIndex]
	#modulate = Color.from_hsv()
	#var tankHsv = currentColor.to_hsv()
	pass

func _physics_process(delta):
	Rotation()
	Movement(delta)
	Shoot()
	POWER()

var hasPressedPower = false
func POWER():
	if Input.is_joy_button_pressed(playerIndex,9):
		if !hasPressedPower:
			hasPressedPower = true
			PlayerG.playerPower[playerIndex] = !PlayerG.playerPower[playerIndex]
			print(PlayerG.playerPower[playerIndex])
	else: hasPressedPower = false
	if PlayerG.playerPower[playerIndex]:
		#$BodyPower.show()
		#$NozzlePower.show()
		$HeadPower.show()
	else:
		#$BodyPower.hide()
		#$NozzlePower.hide()
		$HeadPower.hide()

var rotate
func Rotation():
	if playerIndex == 4: rotate = Input.get_action_strength("rotate right") - Input.get_action_strength("rotate left")
	else: rotate = Input.get_joy_axis(playerIndex,2)
	
	if Input.is_joy_button_pressed(playerIndex,JOY_BUTTON_B):
		rotate = 1
	elif Input.is_joy_button_pressed(playerIndex,JOY_BUTTON_X):
		rotate = -1
		
	if rotate<-0.1 or rotate>0.1:
		rotation_degrees += rotate * rotationSPEED

var desired_velocity := Vector2.ZERO
var steering_velocity := Vector2.ZERO
func Movement(a):
	#var direction = Input.get_vector('rotate left','rotate right','forward','back')
	#desired_velocity = direction * SPEED
	#steering_velocity = desired_velocity - velocity
	#velocity += steering_velocity * drag_factor
	#velocity = direction * SPEED
	#rotation = velocity.angle()
	
	#look_at(get_global_mouse_position())
	var move
	var forward_vector = (Vector2(cos(-rotation), sin(rotation)))
	if playerIndex == 4: move = Input.get_action_strength("forward") - Input.get_action_strength("back")
	else: move = Input.get_joy_axis(playerIndex,1)*-1
	if move<-0.1 or move>0.1:
		velocity = forward_vector * move * SPEED
	else:
		velocity = Vector2.ZERO
	PlayerG.playerForwardV[playerIndex] = forward_vector
	translate(velocity * a)
	move_and_slide()

var hasShot = false #prevents shooting multiple bullets when pressing one button
func Shoot():
	if PlayerG.pBulletCount[playerIndex] >= bulletCount: return
	if playerIndex == 4: 
		if Input.is_action_just_pressed("shoot"):
			if !hasShot:
				print(hasShot)
				var bullet = plBullet.instantiate()
				bullet.position.x += 15
				#bullet.rotation_degrees = rotation_degrees
				add_child(bullet); bullet.reparent(get_parent())
				print("SHOOT")
	else:
		if Input.is_joy_button_pressed(playerIndex,10):# or Input.is_action_just_pressed("shoot"): #presses RB / R1 / R
			if !hasShot:
				print(hasShot)
				var bullet = plBullet.instantiate()
				bullet.position.x += 15
				#bullet.rotation_degrees = rotation_degrees
				add_child(bullet); bullet.reparent(get_parent())
				print("SHOOT")
				hasShot = true
		else: hasShot = false;#print(hasShot)
