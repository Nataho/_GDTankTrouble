extends Button

@onready var animate: AnimationPlayer = $Animate

func _ready() -> void:
	focus_entered.connect(focused)
	focus_exited.connect(unfocused)
func focused():
	animate.play("selected")
	modulate = Color.DARK_KHAKI

func unfocused():
	animate.play("deselected")
	modulate = Color.WHITE
