extends Area2D

enum powerUps {
	none,
	mouse,
	elephant,
	speed,
}
@export var selectedPower: powerUps
var spawned = false
var landed = false

var Sprites:Dictionary = {
	1: "res://Assets/Photos/PowerUps/PowerUpMouse.png",
	2: "res://Assets/Photos/PowerUps/PowerupElephant.png",
	3: "res://Assets/Photos/PowerUps/PowerupSpeed.png",
}

var isTexture = false
func _ready() -> void:
	$Animate.play("RESET")
	spawn()
func spawn():
	isTexture = false; 
	hide()
	
	$Show.start()
	spawned = false
	var WindowSize = Vector2(2560,1440)
	#if selectedPower == powerUps.mouse: modulate = Color.DODGER_BLUE
	#elif selectedPower == powerUps.elephant:
		#
	#elif selectedPower == powerUps.speed: modulate = Color.LIGHT_SEA_GREEN
	$Sprite2D.texture = load(Sprites[selectedPower])
	isTexture = true; $Animate.play("RESET - Texture")
	
	while !spawned:
		randomize()
		var screenEdge = 50
		var rngX = randi_range(screenEdge, WindowSize.x - screenEdge)
		var rngY = randi_range(screenEdge, WindowSize.y - screenEdge)
		var rngRot = randi_range(-45,45)
		
		rotation_degrees = rngRot
		position = Vector2(rngX,rngY)
		spawned = true

func Player_Contact(body):
	if body.name == "Walls":
		spawn()
		return
	if body in get_tree().get_nodes_in_group("PowerUp"): print("ASDLFKJASLDFJASF")
	
	if body in get_tree().get_nodes_in_group("Player") && landed:
		
		if selectedPower == powerUps.mouse: #mouse
			body.power_reset()
			var Scale
			if body.tankScale > 1: Scale = 1; body.power_reset(); queue_free(); return
			else: Scale = 0.5; body.set_tank_power_color(Color(0.11, 0.56, 100, 1))
			body.set_tank_scale(Scale)
			body.start_power_timer(15)
		print("player ", body.playerIndex, " got a powerup!")
		print(selectedPower)
		
		if selectedPower == powerUps.elephant: #elephant
			body.power_reset()
			var Scale
			if body.tankScale < 1: Scale = 1; body.power_reset(); queue_free(); return
			else: Scale = 2.5; body.set_tank_power_color(Color(48.62, 0.50, 0.48, 1))
			body.set_tank_scale(Scale)
			body.start_power_timer(15)
			
		
		if selectedPower == powerUps.speed: #speed
			body.set_tank_power_color(Color(0, 5.69, 5.66, 1))
			body.set_tank_scale(1)
			body.set_tank_speed(2)
			body.start_power_timer(15)
			
		
	
	queue_free()

func Self_Contact(body):
	if body.name == "PowerUp":
		spawn()
		return

#runs when player is ready to spawn
func Self_Show():
	show()
	$Show.stop()
	if !isTexture: $Animate.play("Drop")
	elif isTexture: $Animate.play("Drop - Texture")
	await $Animate.animation_finished
	landed = true
