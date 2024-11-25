extends CanvasLayer

@onready var label: Label = $Label

var cycles = 0
var PeriodAmount = 0
func Refresh():
	$Label.text += "."; PeriodAmount += 1
	if PeriodAmount >3: PeriodAmount = 0; $Label.text = "Loading"
	$Refresh.wait_time = randf_range(0.1,0.7)
	
	cycles += 1
	if cycles == 20: Transition.ChangeScene("FFA 01","slideRight")
