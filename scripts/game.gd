extends Node2D
@onready var claw = $Claw/Claw

func _process(_delta):
	if Globals.grabbed_item != null and Globals.grab:
		var _offx = 50
		var _offy = 80
		
		Globals.grabbed_item.global_position = Vector2(claw.position.x + _offx, claw.position.y + _offy)
		var _t = get_tree().create_tween().set_loops(20)
		_t.tween_property(Globals.grabbed_item, "rotation", deg_to_rad(360), 2.0)
#		

