extends Area2D

@export var SPEED := 500.0

var velocity := Vector2.ZERO
var forward_vector

func _ready():
	var rot = deg_to_rad(rotation_degrees)
	forward_vector = PlayerG.playerForwardV #for forward direction
	print(rot)

func _physics_process(delta:float) -> void:
	#forward_vector = PlayerG.playerForwardV #for homming missile
	velocity = forward_vector * SPEED
	translate(velocity * delta)
	pass

func die():
	queue_free()
