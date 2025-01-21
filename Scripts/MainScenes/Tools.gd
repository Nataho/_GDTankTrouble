class_name TOOLS
#region glow&natural
const A = 2.294
const B = 1.392

#turns glowing color value into natural color value
static func _get_unGlow(natural:float) -> float:
	return 1.0 - A * exp(-B * natural)
	
#turns natural color value to glowing color value
static func _get_Glow(opposite:float):
	if opposite >= 1.0: return 0.0
	return log((1.0 - opposite) / A) / -B

#turns glowing color into natural color
static func get_unGlow_Color(naturalColor: Color):
	var oppositeColor: Color
	
	oppositeColor.r = _get_unGlow(naturalColor.r) #red
	oppositeColor.g = _get_unGlow(naturalColor.g) #green
	oppositeColor.b = _get_unGlow(naturalColor.b) #blue
	oppositeColor.a = 1 #alpha / opacity
	return oppositeColor
#endregion glow&natural

#region natural rotation
static func get_natural_rotation(parent: Node2D, child: Node2D):
	var parent_rot = parent.global_rotation
	var child_rot = child.global_rotation
	child_rot = 0
	child.global_rotation = child_rot
#endregion natural rotation
