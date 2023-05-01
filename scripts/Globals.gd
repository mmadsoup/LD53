extends Node

signal emit_placement_particles
signal screen_shake

signal change_charpic_irritated
signal change_charpic_happy

signal change_truck_area_collision_layer

signal play_correct_sound
signal play_incorrect_sound
signal play_drop_sound

var currentQuests = []
var currentQuestNames = []
var fulfilled = []

var quest_boxes = [] # Store boxes for quests so we can highlight them at game start

var grabbed_item
var grab = false

var totalboxes = 6  #increase to up difficulty?

var score = 0
var level = 1
var scoreMultiplier=100
