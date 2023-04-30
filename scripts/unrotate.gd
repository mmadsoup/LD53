extends Sprite2D

@onready var pops = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	rotation = -1* pops.rotation #this neutralizes all rotation
	
	
	if Globals.grab==false: #we might need to add an aditional check here for claw?
		rotation += snapped(pops.rotation,PI/6)

