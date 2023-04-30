extends RigidBody2D
@onready var area_2d = $Area2D

func _on_area_2d_body_entered(body):
	if str(body).split(":")[0] == "Claw":
		Globals.grabbed_item = self
		area_2d.queue_free()
