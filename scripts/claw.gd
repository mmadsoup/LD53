extends Node2D

@onready var line_2d = $Line2D
@onready var pivot = $Pivot
@export var move_speed = 30
@onready var claw = $Claw
@onready var damped_spring_joint_2d = $DampedSpringJoint2D

func _ready():
	line_2d.add_point(pivot.position, 0)
	line_2d.add_point(claw.position, 1)
	line_2d.width = 1.0

func _process(delta):
	#print (Globals.grabbed_item)
	line_2d.set_point_position(0, pivot.position)
	line_2d.set_point_position(1, Vector2(claw.position.x, claw.position.y - 4))
	
	if Input.is_action_pressed('ui_left'):
		pivot.position.x -= move_speed * delta
	elif Input.is_action_pressed('ui_right'):
		pivot.position.x += move_speed * delta
		
	if Input.is_action_just_pressed('ui_select'):
		if Globals.grabbed_item == null:
			Globals.grab = !Globals.grab
		if Globals.grabbed_item != null and Globals.grab:
			Globals.grabbed_item._release()
			#Globals.grabbed_item.apply_impulse(Vector2(0, 10), Vector2(Globals.grabbed_item.global_position.x, 530))
		
		if Globals.grab:
			damped_spring_joint_2d.rest_length = 100
		else:
			damped_spring_joint_2d.rest_length = 5
		
	if Globals.grab and Globals.grabbed_item != null:
		damped_spring_joint_2d.rest_length = 5
