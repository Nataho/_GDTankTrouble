extends Button

@onready var animate: AnimationPlayer = $Animate

func _ready() -> void:
	focus_entered.connect(focused)
	focus_exited.connect(unfocused)
	await get_tree().create_timer(0.01).timeout
	if disabled: modulate = Color.DARK_SALMON
	
func focused():
	animate.play("selected")
	if disabled: 
		modulate = Color.SALMON
		return
		
	modulate = Color.DARK_KHAKI

func unfocused():
	animate.play("deselected")
	if disabled:
		modulate = Color.DARK_SALMON
		return
	modulate = Color.WHITE
