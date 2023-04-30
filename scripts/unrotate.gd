extends Sprite2D

@onready var pops = get_parent()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#print(self)
	#if pops.name=="Claw" ||Globals.grabbed_item==pops:
	rotation = -1* pops.rotation #this neutralizes all rotation
	
	
	if Globals.grab==false || not pops.name=="Claw":
		rotation += snapped(pops.rotation,PI/6)


