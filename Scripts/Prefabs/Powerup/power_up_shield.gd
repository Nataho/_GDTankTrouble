extends StaticBody2D
class_name SHIELD

enum _states {
	SPAWN_SHIELD,
	POWERUP_SHIELD
}

@export var damageColor: Color
@export var active:bool = false
@export var state:_states
@export var shieldPontRange: Vector2 = Vector2(0,3)
var SP #shield points
var canSlide = false

@onready var sprite: Sprite2D = $Sprite2D
@onready var spawnTimer: Timer = $SpawnShieldTimer
@onready var slide: Timer = $slide
@onready var anim: AnimationPlayer = $Anim

func _process(delta: float) -> void:
	if !active: return #stop if not active
	TOOLS.get_natural_rotation(self,sprite)

func _ready() -> void:
	start_shield(state)
	
func start_shield(newState:_states):
	active = true
	if newState == _states.SPAWN_SHIELD: spawnTimer.start()
	if newState == _states.POWERUP_SHIELD:
		SP = shieldPontRange.y

#region runtime
#bullet scene calls this function
func hit():
	if state == _states.SPAWN_SHIELD:
		anim.play("hit")
	if state == _states.POWERUP_SHIELD:
		damageSheild()
		print("hit")
	slide.start()
	canSlide = true

func spawnShield_end():
	_removeSheild()

func damageSheild(damage = 1): #for powerup shield
	if canSlide: return
	SP -= damage
	anim.play("damage")
	if SP <= 0:
		queue_free() #remove shield from parent when no SP left
#endregion runtime

func releaseSlide(): canSlide = false
func _removeSheild():
	active = false
	queue_free()
