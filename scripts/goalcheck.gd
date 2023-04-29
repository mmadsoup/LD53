extends Node2D

@onready var ui = get_node("/root/selkietest/UI")

func _on_area_2d_body_entered(body):

	body.queue_free()
	Global.fulfilled.append(str(body.name))
	if Global.currentQuests.has(body.name):
		#Global.currentQuests.erase(body.name)
		ui.populateQuestUI() #maybe we'll remove all dupes and then do strikethru or smth? more work tho
		checkVictory()
		
func checkVictory():
	print(Global.fulfilled)
	var a = Global.currentQuests.duplicate() #itll sort the main array if we dont do it like this
	a.sort()
	var b = Global.fulfilled.duplicate()
	b.sort()

	if a.hash()==b.hash():
		victory()
func victory():
	$AnimationPlayer.play("truck_depart")
