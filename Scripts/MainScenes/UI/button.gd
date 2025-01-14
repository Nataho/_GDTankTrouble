extends Button

@onready var animate: AnimationPlayer = $Animate
var LogoMoveFreq: float = 1 ; var LogoRotFreq: float = 2
var LogoMoveAmp: float = 20 ; var LogoRotAmp: float = 1000
var time = 0
var scaleUp := 1
var sfx = [
	preload("res://Assets/Audio/SFX/UI/ui_world_icon_roll_left.wav"),
	preload("res://Assets/Audio/SFX/UI/ui_world_icon_roll_right.wav"),
]
func _ready() -> void:
	setFontSize()
	$Text/arrow.hide()
	
	%Text.text = text
	text = " "
	focus_entered.connect(focused)
	focus_exited.connect(unfocused)
	await get_tree().create_timer(0.01).timeout
	if disabled: modulate = Color.DARK_SALMON

#func setFontSize(control:Control, Size:int):
func setFontSize():
	var fntsz = self.get_theme_font_size("font_size")
	%Text.add_theme_font_size_override("font_size",fntsz)
	pass


func _physics_process(delta: float) -> void:
	$Text/arrow.rotation += 1*delta 
	
	time += delta
	var movement = cos(time*LogoMoveFreq)*LogoMoveAmp
	var _rotate = cos(time*LogoRotFreq)*LogoRotAmp
	$Text/arrow.position.y += movement * delta
	$Text/arrow.rotation_degrees += _rotate * delta / 10
	
	#var Scale = Vector2(scaleUp,scaleUp)
	#var buttonScale = scale
	#var newScale: Vector2
	#
	#newScale.x = lerpf(scale.x,Scale.x,5*delta)
	#newScale.y = lerpf(scale.y,Scale.y,5*delta)
	#
	#scale = newScale
	
func focused():
	animate.play("selected")
	$Text/arrow.show()
	PlaySfx()
	if disabled: 
		modulate = Color.SALMON
		return
		
	modulate = Color.DARK_KHAKI

func unfocused():
	animate.play("deselected")
	$Text/arrow.hide()
	if disabled:
		modulate = Color.DARK_SALMON
		return
	modulate = Color.WHITE

func PlaySfx():
	var sound = sfx[randi_range(0,1)]
	$sfx.stream = sound
	$sfx.play()
