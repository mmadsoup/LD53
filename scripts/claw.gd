extends Node2D

@onready var line_2d = $Line2D
@onready var pivot = $Pivot
@export var move_speed = 50
@onready var claw = $Claw
@onready var damped_spring_joint_2d = $DampedSpringJoint2D

var grab = false

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
	if Input.is_action_pressed('ui_right'):
		pivot.position.x += move_speed * delta
	if Input.is_action_just_pressed('ui_select'):
		grab = !grab
