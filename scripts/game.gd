extends Node2D
@onready var claw = $Claw/Claw
@onready var clawt = $Claw/Claw/Sprite2D/RemoteTransform2D
@onready var gpu_particles_2d = $GPUParticles2D
var placement_particle = preload('res://vfx/placement_dust.tscn')
func _ready():
	Globals.connect('emit_placement_particles', emit_placement_particles)

func _process(_delta):
	if Input.is_action_just_pressed('ui_up'):
		gpu_particles_2d.restart()
		gpu_particles_2d.position = claw.position
		gpu_particles_2d.emitting = true
	
	if Globals.grabbed_item != null and Globals.grab:
		clawt.remote_path=Globals.grabbed_item.get_path()
	else:
		clawt.remote_path=""
func emit_placement_particles(pos):
	var _p = placement_particle.instantiate()
	_p.position = Vector2(pos.x, pos.y + 10)
	add_child(_p)
	_p.emitting = true
		
#		Globals.grabbed_item.global_position = Vector2(claw.position.x + _offx, claw.position.y + _offy)
#		var _t = get_tree().create_tween().set_loops(20)
#		_t.tween_property(Globals.grabbed_item, "rotation", deg_to_rad(360), 2.0)
		#Globals.grabbed_item.rotation =  claw.rotation
		#print(Globals.grabbed_item.rotation)

