extends Control

@onready var timer = $Timer
@onready var label = $Label

func _ready():
	Globals.connect('reset_timer', reset_timer)

func _process(_delta):
	label.text = str(ceil(timer.time_left))
	
	if timer.time_left <= 0:
		#Globals.emit_signal('play_scene_transition', )
		get_tree().change_scene_to_file('res://scenes/end.tscn')

func reset_timer():
	timer.start(60)
