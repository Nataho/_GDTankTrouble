extends CharacterBody2D

const SPEED = 300.0
const rotationSPEED = 5.0

var velo: Vector2 = Vector2.ZERO
var plBullet := preload("res://Scenes/Prefabs/bullet.tscn")


func _physics_process(delta):
	Rotation()
	Movement(delta)
	Shoot()

func Rotation():
	var rotate = Input.get_action_strength("rotate right") - Input.get_action_strength("rotate left")
	if rotate != 0:
		rotation_degrees += rotate * rotationSPEED

func Movement(a):
	var forward_vector = -(Vector2(cos(-rotation), sin(rotation)))
	var move = Input.get_action_strength("forward") - Input.get_action_strength("back")
	if move != 0:
		velocity = forward_vector * move * SPEED
	else:
		velocity = Vector2.ZERO
	translate(velocity * a)

func Shoot():
	if Input.is_action_just_pressed("shoot"):
		var bullet = plBullet.instantiate()
		bullet.position.x -= 15
		bullet.rotation_degrees = self.rotation_degrees
		add_child(bullet); bullet.reparent(get_parent())
		print("SHOOT")
		
