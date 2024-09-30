extends CharacterBody2D

var SPEED = 250

func _ready():
	velocity = Vector2(-200, -200).normalized() * SPEED

func _physics_process(delta):
	var collision = move_and_collide(velocity*delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
	if collision and collision.get_collider().name == "Walls": print("you have hit a wall")
