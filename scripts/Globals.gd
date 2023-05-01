extends Node

signal emit_placement_particles
signal screen_shake

signal change_charpic_irritated
signal change_charpic_happy

var currentQuests = []
var currentQuestNames = []
var fulfilled = []

var quest_boxes = [] # Store boxes for quests so we can highlight them at game start

var grabbed_item
var grab = false

var totalboxes = 6  #increase to up difficulty?
