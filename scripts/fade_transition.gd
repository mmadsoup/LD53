extends Node2D
@onready var fade_transition_rect = $FadeTransitionRect
@onready var fade_animation_player = $FadeAnimationPlayer

func _ready():
	fade_in_transition()
	Globals.connect('play_fade_in_transition', fade_in_transition)
	Globals.connect('play_fade_out_transition', fade_out_transition)

func fade_in_transition():
	fade_transition_rect.color = Color(0, 0, 0, 1)
	fade_animation_player.play('FadeIn')

func fade_out_transition():
	fade_animation_player.play('FadeOut')
