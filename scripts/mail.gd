extends RigidBody2D
@onready var area_2d = $Area2D
@onready var collision_shape_2d = $CollisionShape2D

func _ready():
	pass # Replace with function body.

func _process(_delta):
	if Globals.grabbed_item != null:
		var _offx = 50
		var _offy = 80
		global_position = Vector2(Globals.grabbed_item.position.x + _offx, Globals.grabbed_item.position.y + _offy)
		
		var _t = get_tree().create_tween().set_loops(20)
		_t.tween_property(self, "rotation", deg_to_rad(360), 2.0)
		
		if Input.is_action_just_pressed('ui_select'):
			Globals.grabbed_item = null
			Globals.grab = false
	
func _on_area_2d_body_entered(body):
	if str(body).split(":")[0] == "Claw":
		Globals.grabbed_item = body
