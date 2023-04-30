extends RigidBody2D
@onready var area_2d = $Area2D
var claw


func _on_area_2d_body_entered(body):
	if str(body).split(":")[0] == "Claw" &&Globals.grab:
		claw = body
		Globals.grabbed_item = self

		$Area2D.collision_layer = 4

		#area_2d.queue_free()
	if str(body).split(":")[0] == 'StaticBody2D':
		Globals.emit_signal('emit_placement_particles', self.position)

func _release():
	global_position=claw.global_position
	Globals.grabbed_item = null
	Globals.grab = false
	await get_tree().create_timer(1.0).timeout
	$Area2D.collision_layer = 1
