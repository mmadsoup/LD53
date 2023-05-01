extends CanvasLayer

const validObjectCharacters ="123457890abcdefgjklmnopqrstuvwxyzBCDEFGHIJKLMNOPQRSTUVWXYZ"
const validColors=["ff5470","7fceff","ff9b71","00bcaa"]
 #"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
const maxDuplicates = 3 #maybe this will do something later if we need it, using count()
var numberOfObjectsNeeded = 4
var totalboxes = 30  #increase to up difficulty?
@onready var charwindow = $ColorRect/Charwindow
@export var spawnPoints:Node2D
@export var testBox:PackedScene
@export var box_shapes : Array[PackedScene]
@export var questPrompt:PackedScene

var outline_shader = preload('res://material_shader/outlineThatDisrespectsBoundaries.gdshader')

#var charpic_irritated = preload('res://assets/ui/charwindow-irritated.png')
#var charpic_neutral = preload('res://assets/ui/charwindow-neutral.png')
#var charpic_happy = preload('res://assets/ui/charwindow-happy.png')

func randomColor():
	return validColors[randi_range(0,validColors.size()-1)]
func _ready():
	generateQuest()
	Globals.connect('change_charpic_irritated', change_charpic_irritated)
	Globals.connect('change_charpic_happy', change_charpic_happy)
	highlight_quest_boxes()
	
func generateQuest():
	for left in numberOfObjectsNeeded:
		var obj = randomLetter()
		Globals.currentQuests.append([obj,randomColor()])
	populateQuestUI(true)
func randomLetter():
	var l = validObjectCharacters[randi_range(0,validObjectCharacters.length()-1)]
	return l 

func populateQuestUI(makeBoxes:bool=false):
	for x in $VBoxContainer.get_children():
		x.queue_free()
	var coveredChars = [] # i dont like this but whatever
	for q in Globals.currentQuests:
		if q[0] not in coveredChars:
			if q[0] in Globals.fulfilled:
				pass
			else:
				var n = questPrompt.instantiate()
				n.get_child(0).text=str(Globals.currentQuests.count(q))+"[font_size=13][color=#"+q[1]+"][outline_size=4][font=res://assets/ui/Pixel Icons Compilation.ttf]"+q[0]+"[/font][/outline_size][/color][/font_size]"
				$VBoxContainer.add_child(n)
			coveredChars.append(q[0])
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

func _makeTestBoxes(): #random boxes here
	var leftOverChars = validObjectCharacters
	var boxestomake = totalboxes
	for g in Globals.currentQuests:
		boxestomake-=1
		var _r = RandomNumberGenerator.new()
		_r.randomize()
		var _n = _r.randi_range(0, box_shapes.size() - 1)
		
		var _b = box_shapes[_n].instantiate()
		_b.name = g[0]
		_b.find_child("Sprite2D").find_child("boxLabel").find_child("Label").text = g[0]
		_b.find_child("Sprite2D").find_child("boxLabel").find_child("Label").add_theme_color_override("font_color",g[1])
		_b.set_position(spawnPoints.get_child (randi_range(0,spawnPoints.get_child_count()-1)).position)
		get_parent().add_child.call_deferred(_b)
		
		Globals.quest_boxes.append(_b)
		
		if leftOverChars.contains(g[0]):
			leftOverChars.replace(g[0],'')
	for b in boxestomake:
		var _r = RandomNumberGenerator.new()
		_r.randomize()
		var _n = _r.randi_range(0, box_shapes.size() - 1)
		
		var fakename = leftOverChars[randi_range(0,leftOverChars.length()-1)]
		
		var _b = box_shapes[_n].instantiate()
		_b.name = fakename
		_b.find_child("Sprite2D").find_child("boxLabel").find_child("Label").text = fakename
		_b.find_child("Sprite2D").find_child("boxLabel").find_child("Label").add_theme_color_override("font_color",randomColor())
		_b.set_position(spawnPoints.get_child (randi_range(0,spawnPoints.get_child_count()-1)).position)
		get_parent().add_child.call_deferred(_b)
#		var box = testBox.instantiate()
#		box.name = g
#		box.find_child("Sprite2D").find_child("boxLabel").find_child("Label").text = g
#		box.set_position(testSpawn.position)
#		get_parent().add_child.call_deferred(box)

func change_charpic_irritated():
	charwindow.play("irritated")
	#charwindow.texture = charpic_irritated
	await get_tree().create_timer(1.0).timeout
	#charwindow.texture = charpic_neutral
	charwindow.play("neutral")
func change_charpic_happy():
	#charwindow.texture = charpic_happy
	charwindow.play("happy")
	await get_tree().create_timer(1.0).timeout
	#charwindow.texture = charpic_neutral
	charwindow.play("neutral")
	
func highlight_quest_boxes():
	for i in Globals.quest_boxes:
		var _m = ShaderMaterial.new()
		_m.set_shader_parameter('width', 1.5)
		_m.set_shader(outline_shader)
		var _b = i.get_child(0)
		_b.material = _m
	
	await get_tree().create_timer(5.0).timeout
	for i in Globals.quest_boxes:
		var _b = i.get_child(0)
		_b.set_material(null)
