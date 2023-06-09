extends Node

signal emit_placement_particles
signal screen_shake

signal change_charpic_irritated
signal change_charpic_happy

signal change_truck_area_collision_layer

signal play_correct_sound
signal play_incorrect_sound
signal play_drop_sound

signal play_scene_transition
signal play_fade_in_transition
signal play_fade_out_transition

signal spawn_boxes

signal update_score
signal reset_timer

var currentQuests = []
var currentQuestNames = []
var fulfilled = []

var all_boxes = []
var quest_boxes = [] # Store boxes for quests so we can highlight them at game start

var grabbed_item
var grab = false

var totalboxes = 6  #increase to up difficulty?
var totalboxesIncrement = 3 #how many boxes add per level
var score = 0
var level = 1
var scoreMultiplier=100
