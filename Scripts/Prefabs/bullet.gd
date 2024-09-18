extends Area2D

@export var SPEED := 500.0

var velocity: Vector2 = Vector2.ZERO

func _ready():
	var rot = deg_to_rad(rotation_degrees)
	print(rot)

func _physics_process(delta):
	var rot = deg_to_rad(rotation_degrees)
	var forward_vector = Vector2(cos(rot), sin(rot))
	velocity = forward_vector * SPEED
	translate(velocity * delta)

func die():
	queue_free()
