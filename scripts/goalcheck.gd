extends Node2D

@onready var ui = get_node("/root/Game/UI")
@onready var area_2d = $Area2D
@onready var transition = get_node("/root/Game/screenTransition")
func _ready():
	Globals.connect('change_truck_area_collision_layer', change_collision_layer)

func _on_area_2d_body_entered(body):
	Globals.fulfilled.append(str(body.name))
	if Globals.currentQuestNames.has(body.name):
		#Globals.currentQuests.erase(body.name)
		ui.populateQuestUI() #maybe we'll remove all dupes and then do strikethru or smth? more work tho
		checkVictory()
		Globals.emit_signal('change_charpic_happy')
	else:
		if str(body.name) != 'Claw' and str(body.name) != 'StaticBody2D':
			Globals.emit_signal('change_charpic_irritated')
		
func checkVictory():
	#print(Globals.fulfilled)
	var a = Globals.currentQuests.duplicate() #itll sort the main array if we dont do it like this
	a.sort()
	var b = Globals.fulfilled.duplicate()
	b.sort()

	if a.hash()==b.hash():
		victory()
	Globals.score+=Globals.scoreMultiplier*Globals.fulfilled.size()
	print("score is  "+str(Globals.score))
func victory():
	$AnimationPlayer.play("truck_depart")
	await get_tree().create_timer(0.8).timeout
	Globals.level+=1
	transition.find_child("Label").text="Level"+str(Globals.level)
	transition.find_child("AnimationPlayer").play("LevelTransition")
	#reset level now

func _on_area_2d_body_exited(body):
	Globals.fulfilled.erase(str(body.name))
	if Globals.currentQuests.has(body.name):
		#Globals.currentQuests.erase(body.name)
		ui.populateQuestUI() #maybe we'll remove all dupes and then do strikethru or smth? more work tho
		
func change_collision_layer():
	if Globals.grabbed_item == null and not Globals.grab:
		area_2d.collision_mask = 1
	else:
		area_2d.collision_mask = 6

