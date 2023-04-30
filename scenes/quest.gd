extends CanvasLayer

const validObjectCharacters ="123457890abcdefgjklmnopqrstuvwxyzBCDEFGHIJKLMNOPQRSTUVWXYZ"
 #"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
const maxDuplicates = 3 #maybe this will do something later if we need it, using count()
var numberOfObjectsNeeded = 4

@export var testSpawn:Node2D
@export var testBox:PackedScene
@export var questPrompt:PackedScene
func _ready():
	generateQuest()
	

func generateQuest():
	for left in numberOfObjectsNeeded:
		var obj = randomLetter()
		Globals.currentQuests.append(obj)
	populateQuestUI(true)
func randomLetter():
	var l = validObjectCharacters[randi_range(0,validObjectCharacters.length()-1)]
	return l 

func populateQuestUI(makeBoxes:bool=false):
	for x in $VBoxContainer.get_children():
		x.queue_free()
	var coveredChars = [] # i dont like this but whatever
	for q in Globals.currentQuests:
		if q not in coveredChars:
			if q in Globals.fulfilled:
				pass
			else:
				var n = questPrompt.instantiate()
				n.get_child(0).text=str(Globals.currentQuests.count(q))+"[font_size=13][color=#ff5470][font=res://assets/ui/Pixel Icons Compilation.ttf]"+q+"[/font][/color][/font_size]"
				$VBoxContainer.add_child(n)
			coveredChars.append(q)
	if makeBoxes:_makeTestBoxes()
#func populateQuestUI(makeBoxes:bool=false):
#	$label_needs/quests.text=''
#	var coveredChars = [] # i dont like this but whatever
#	for q in Globals.currentQuests:
#		if q not in coveredChars:
#			if q in Globals.fulfilled:
#				$label_needs/quests.text+="[s]" +str(Globals.currentQuests.count(q))+"x [font=res://assets/ui/Pixel Icons Compilation.ttf][color=green]"+q+"[/color][/font][/s]\n"
#			else:
#				$label_needs/quests.text+= str(Globals.currentQuests.count(q))+"x [font=res://assets/ui/Pixel Icons Compilation.ttf][color=red]"+q+"[/color][/font]\n"
#			coveredChars.append(q)
#	if makeBoxes:_makeTestBoxes()



func _makeTestBoxes():
	for g in Globals.currentQuests:

		var box = testBox.instantiate()
		box.name = g
		box.find_child("Sprite2D").find_child("boxLabel").find_child("Label").text = g
		box.set_position(testSpawn.position)
		get_parent().add_child.call_deferred(box)
