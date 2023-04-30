extends Camera2D
@onready var shaker = $'../Shaker'

func _ready():
	Globals.connect('screen_shake', screen_shake)

func screen_shake():
	shaker.start(1.0)
