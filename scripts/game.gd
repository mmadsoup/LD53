extends Node2D
@onready var claw = $Claw/Claw
@onready var clawt = $Claw/Claw/Sprite2D/RemoteTransform2D
func _process(_delta):
	if Globals.grabbed_item != null and Globals.grab:
		var _offx = 1
		var _offy = 20
		clawt.remote_path=Globals.grabbed_item.get_path()
	else:
		clawt.remote_path=""
		
#		Globals.grabbed_item.global_position = Vector2(claw.position.x + _offx, claw.position.y + _offy)
#		var _t = get_tree().create_tween().set_loops(20)
#		_t.tween_property(Globals.grabbed_item, "rotation", deg_to_rad(360), 2.0)
		#Globals.grabbed_item.rotation =  claw.rotation
		#print(Globals.grabbed_item.rotation)

