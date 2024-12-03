extends Area2D

enum powerUps {
	none,
	mouse,
	elephant,
	speed,
	slow,
	multi_shot,
	random,
}
@export var selectedPower: powerUps
var spawned = false
var landed = false

var Sprites:Dictionary = {
	powerUps.mouse: "res://Assets/Photos/PowerUps/PowerUpMouse.png",
	powerUps.elephant: "res://Assets/Photos/PowerUps/PowerupElephant.png",
	powerUps.speed: "res://Assets/Photos/PowerUps/PowerupSpeed.png",
	powerUps.slow: "res://Assets/Photos/PowerUps/Sticky!.png",
	powerUps.multi_shot: "res://Assets/Photos/PowerUps/Multishot.png",
	powerUps.random: "res://Assets/Photos/PowerUps/PowerUpMystery.png",
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

var wasRandom = false
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
			body.set_multi_shot(false)
			body.set_tank_scale(1)
			body.set_tank_speed(2)
			body.start_power_timer(15)
		
		if selectedPower == powerUps.slow:
			body.set_tank_power_color(Color(0,5,0,1))
			body.set_multi_shot(false)
			body.set_tank_scale(1)
			body.set_tank_speed(0.7)
			body.start_power_timer(15)
		
		if selectedPower == powerUps.multi_shot:
			body.power_reset()
			body.set_tank_power_color(Color(5,5,0,1))
			body.set_multi_shot(true)
			body.start_power_timer(15)
		
		if selectedPower == powerUps.random:
			selectedPower = randi_range(powerUps.none,powerUps.random-1)
			wasRandom = true
			Player_Contact(body)
		
	if wasRandom: 
		if selectedPower != 0: $Sprite2D.texture = load(Sprites[selectedPower])
		else: $Sprite2D.texture = load(Sprites[powerUps.random])
		$Animate.play("Fly - Texture")
		monitoring = false
		monitorable = false
		await $Animate.animation_finished
		
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
