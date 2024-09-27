extends CharacterBody2D

const SPEED = 300.0
const rotationSPEED = 5.0

@export_range(0,10,0.1) var drag_factor := 0.1

var velo: Vector2 = Vector2.ZERO
var plBullet := preload("res://Scenes/Prefabs/bullet.tscn")


func _physics_process(delta):
	Rotation()
	Movement(delta)
	Shoot()
	POWER()

func POWER():
	if PlayerG.playerPower:
		$BodyPower.show()
		$NozzlePower.show()
		$HeadPower.show()
	else:
		$BodyPower.hide()
		$NozzlePower.hide()
		$HeadPower.hide()

func Rotation():
	var rotate = Input.get_action_strength("rotate right") - Input.get_action_strength("rotate left")
	if rotate != 0:
		rotation_degrees += rotate * rotationSPEED

var desired_velocity := Vector2.ZERO
var steering_velocity := Vector2.ZERO
func Movement(a):
	##
	#var direction = Input.get_vector('rotate left','rotate right','forward','back')
	#desired_velocity = direction * SPEED
	#steering_velocity = desired_velocity - velocity
	#velocity += steering_velocity * drag_factor
	#velocity = direction * SPEED
	#rotation = velocity.angle()
	#move_and_slide()
	#look_at(get_global_mouse_position())
	
	var forward_vector = (Vector2(cos(-rotation), sin(rotation)))
	var move = Input.get_action_strength("forward") - Input.get_action_strength("back")
	if move != 0:
		velocity = forward_vector * move * SPEED
	else:
		velocity = Vector2.ZERO
	PlayerG.playerForwardV = forward_vector
	translate(velocity * a)

func Shoot():
	if Input.is_action_just_pressed("shoot"):
		var bullet = plBullet.instantiate()
		bullet.position.x += 15
		#bullet.rotation_degrees = rotation_degrees
		add_child(bullet); bullet.reparent(get_parent())
		print("SHOOT")		
