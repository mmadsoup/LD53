extends Node2D
@onready var claw = $Claw/Claw
@onready var clawt = $Claw/Claw/Sprite2D/RemoteTransform2D
var placement_particle = preload('res://vfx/placement_dust.tscn')

func _ready():
	Globals.connect('emit_placement_particles', emit_placement_particles)

func _process(_delta):
	if Globals.grabbed_item != null and Globals.grab:
		clawt.remote_path=Globals.grabbed_item.get_path()
	else:
		clawt.remote_path=""

func emit_placement_particles(pos):
	var _p = placement_particle.instantiate()
	_p.position = Vector2(pos.x, pos.y + 10)
	add_child(_p)
	_p.emitting = true
	#Globals.emit_signal('screen_shake')
	Globals.emit_signal('change_charpic_irritated')
	
		
