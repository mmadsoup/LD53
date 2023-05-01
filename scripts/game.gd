extends Node2D
@onready var claw = $Claw/Claw
@onready var clawt = $Claw/Claw/Sprite2D/RemoteTransform2D

@onready var drop_box = $Audio/DropBox
@onready var truck_idle = $Audio/TruckIdle
@onready var truck_leave = $Audio/TruckLeave
@onready var goal = $goal

@onready var correct_incorrect_sound = $Audio/CorrectIncorrectSound

var placement_particle = preload('res://vfx/placement_dust.tscn')

func _ready():
	Globals.connect('emit_placement_particles', emit_placement_particles)
	Globals.connect('play_correct_sound', play_correct_sound)
	Globals.connect('play_incorrect_sound', play_incorrect_sound)
	Globals.connect('play_drop_sound', play_drop_sound)

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
	#Globals.emit_signal('change_charpic_irritated')
	
func play_correct_sound():
	correct_incorrect_sound.stream = load('res://audio/correct.wav')
	correct_incorrect_sound.play(0.0)
func play_incorrect_sound():
	correct_incorrect_sound.stream = load('res://audio/wrong.wav')
	correct_incorrect_sound.play(0.0)
func play_drop_sound():
	drop_box.play(0.0)
