extends Control

@onready var timer = $Timer
@onready var label = $Label

func _process(_delta):
	label.text = str(ceil(timer.time_left))
	
	if timer.time_left <= 0:
		get_tree().change_scene_to_file('res://scenes/end.tscn')
