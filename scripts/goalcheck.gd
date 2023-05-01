extends Node2D

@onready var ui = get_node("/root/Game/UI")


func _on_area_2d_body_entered(body):

	body.queue_free()
	Globals.fulfilled.append(str(body.name))
	if Globals.currentQuests.has(body.name):
		#Globals.currentQuests.erase(body.name)
		ui.populateQuestUI() #maybe we'll remove all dupes and then do strikethru or smth? more work tho
		checkVictory()
		Globals.emit_signal('change_charpic_happy')
func checkVictory():
	print(Globals.fulfilled)
	var a = Globals.currentQuests.duplicate() #itll sort the main array if we dont do it like this
	a.sort()
	var b = Globals.fulfilled.duplicate()
	b.sort()

	if a.hash()==b.hash():
		victory()
func victory():
	$AnimationPlayer.play("truck_depart")
