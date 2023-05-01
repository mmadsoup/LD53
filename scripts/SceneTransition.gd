extends AnimationPlayer

var scene_to_transition 
var animation_player
# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player = self
	Globals.connect('play_scene_transition', play_scene_transition)

func play_scene_transition(scene):
	play('LevelTransition')
	scene_to_transition = scene

func _on_animation_finished(_anim_name):
	get_tree().change_scene_to_file(scene_to_transition)
