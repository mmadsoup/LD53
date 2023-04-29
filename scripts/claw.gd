extends Node2D

@onready var line_2d = $Line2D
@onready var pivot = $Pivot
@export var move_speed = 50
@onready var claw = $Claw
@onready var damped_spring_joint_2d = $DampedSpringJoint2D


# Called when the node enters the scene tree for the first time.
func _ready():
	line_2d.add_point(pivot.position, 0)
	line_2d.add_point(claw.position, 1)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	line_2d.set_point_position(0, pivot.position)
	line_2d.set_point_position(1, claw.position)
	
	if Input.is_action_pressed('ui_left'):
		pivot.position.x -= move_speed * delta
#		tween_claw_angle(-30, 0.5)
	elif Input.is_action_pressed('ui_right'):
		pivot.position.x += move_speed * delta
#		tween_claw_angle(30, 0.5)
#	else:
#		tween_claw_angle(0, 0.5)
		
	if Input.is_action_just_pressed('ui_select'):
		if Globals.grabbed_item == null:
			Globals.grab = !Globals.grab
		elif Globals.grabbed_item != null and Globals.grab:
			#Globals.grabbed_item.apply_impulse(Vector2(0, 100), Vector2(Globals.grabbed_item.x, 530))
			Globals.grabbed_item = null
			Globals.grab = false
		
		if Globals.grab:
			damped_spring_joint_2d.rest_length = 500
		else:
			damped_spring_joint_2d.rest_length = 100
		
	if Globals.grab and Globals.grabbed_item != null:
		damped_spring_joint_2d.rest_length = 100


func tween_claw_angle(angle, time):
	var _t = create_tween()
	_t.tween_property(claw, "rotation", deg_to_rad(angle), time)
