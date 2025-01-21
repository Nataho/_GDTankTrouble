extends Button

class_name CUSTOM_BUTTON1
@export_group("Arrow")
@export var _customArrowTexture:Texture
@export var _colorMode:_modeColor  = _modeColor.MODULATE

@export_group("Focus Colors")
@export var focusColor:Color = Color.GOLD
@export var disabledFocusColor:Color = Color.SALMON

@export_group("Label Properties")
@export var fontColor:Color = Color(1,1,1,1)
@export var outlineSize:int = 0
@export var outlineColor:Color = Color(0,0,0,1)

@onready var animate: AnimationPlayer = $Animate
@onready var text_label: Label = %Text

@onready var _arrowNode:TextureRect = $Text/arrow

enum _modeColor{MODULATE, FONT}

var _labelSettings:LabelSettings
var LogoMoveFreq: float = 1 ; var LogoRotFreq: float = 2
var LogoMoveAmp: float = 20 ; var LogoRotAmp: float = 1000
var time = 0
var scaleUp := 1
var sfx = [
	preload("res://Assets/Audio/SFX/UI/ui_world_icon_roll_left.wav"),
	preload("res://Assets/Audio/SFX/UI/ui_world_icon_roll_right.wav"),
]
func _ready() -> void:
	#_arrowNode = $Text/arrow
	if _customArrowTexture != null:
		_arrowNode = $Text/customArrow
		_arrowNode.texture = _customArrowTexture
		var arrowNodeSize:Vector2 = _arrowNode.size
		_arrowNode.pivot_offset = Vector2(arrowNodeSize.x/2, arrowNodeSize.y/2)
		print("waht")

	newLabelSettings()
	_arrowNode.hide()
	
	%Text.text = text
	text = " "
	focus_entered.connect(focused)
	focus_exited.connect(unfocused)
	await get_tree().create_timer(0.01).timeout

	if disabled: 
		if _colorMode == _modeColor.FONT:
			_labelSettings.font_color = Color.DARK_SALMON
			return
		modulate = Color.DARK_SALMON
#func setFontSize(control:Control, Size:int):

func newLabelSettings():
	_labelSettings = LabelSettings.new()
	
	var parentFontSize = self.get_theme_font_size("font_size")
	var parentFont = self.get_theme_font("font")
	
	_labelSettings.font_size = parentFontSize
	_labelSettings.font = parentFont
	_labelSettings.font_color = fontColor
	
	_labelSettings.outline_size = outlineSize
	_labelSettings.outline_color = outlineColor
	print("custom button1| parentFontSize: ", parentFontSize)
	print("custom button1| _labelSettings.font_size: ", _labelSettings.font_size)
	
	var algnmnt = alignment
	#%Text.set_horizontal_alignment(algnmnt)
	if algnmnt == 0: $Anchor.play("left")
	elif algnmnt == 1: $Anchor.play("RESET")
	elif algnmnt == 2: $Anchor.play("right")
	
	%Text.label_settings = _labelSettings

func setFontSize():
	var fntsz = self.get_theme_font_size("font_size")
	%Text.add_theme_font_size_override("font_size",fntsz)
	var algnmnt = alignment
	#%Text.set_horizontal_alignment(algnmnt)
	if algnmnt == 0: $Anchor.play("left")
	elif algnmnt == 1: $Anchor.play("RESET")
	elif algnmnt == 2: $Anchor.play("right")
	
	print(%Text.horizontal_alignment)
	pass

func _physics_process(delta: float) -> void:
	_arrowNode.rotation += 0.5*delta 
	
	time += delta
	var movement = cos(time*LogoMoveFreq)*LogoMoveAmp
	var _rotate = cos(time*LogoRotFreq)*LogoRotAmp
	_arrowNode.position.y += movement * delta
	_arrowNode.rotation_degrees += _rotate * delta / 10
	
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
	_arrowNode.show()
	PlaySfx()
	
	if _colorMode == _modeColor.FONT:
		if disabled:
			_labelSettings.font_color = disabledFocusColor
			return
		_labelSettings.font_color = focusColor
		return
		
	if disabled: 
		modulate = disabledFocusColor
		return
		
	#modulate = Color.PALE_GREEN
	modulate = focusColor
	#modulate = Color.DARK_KHAKI

func unfocused():
	animate.play("deselected")
	_arrowNode.hide()
	
	if _colorMode == _modeColor.FONT:
		if disabled:
			_labelSettings.font_color = Color.DARK_SALMON
			return
		_labelSettings.font_color = Color.WHITE
		return
	
	if disabled:
		modulate = Color.DARK_SALMON
		return
	modulate = Color.WHITE

func PlaySfx():
	var sound = sfx[randi_range(0,1)]
	$sfx.stream = sound
	$sfx.play()
