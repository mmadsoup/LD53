extends Control

@onready var timer = $Timer
@onready var label = $Label

func _process(_delta):
	label.text = str(ceil(timer.time_left))
