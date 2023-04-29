extends RigidBody2D
@onready var area_2d = $Area2D
@onready var collision_shape_2d = $CollisionShape2D

func _ready():
	pass # Replace with function body.

func _on_area_2d_body_entered(body):
	if str(body).split(":")[0] == "Claw":
		Globals.grabbed_item = self
