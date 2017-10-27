extends Node

var open_door = true
onready var old_collision_mask = get_node("move_cave_1").get_collision_mask()
onready var old_layer_mask = get_node("move_cave_1").get_layer_mask()
func _ready():
	set_fixed_process(true)
	get_node("move_cave_1").set_collision_mask(0)
	get_node("move_cave_1").set_layer_mask(0)

func _fixed_process(delta):
	if globals.puzzle_1_complete && open_door: 
		get_node("Door").set_animation("door_open")
		get_node("Switch").set_animation("switch_on")
		open_door = false
		get_node("move_cave_1").set_collision_mask(old_collision_mask)
		get_node("move_cave_1").set_layer_mask(old_layer_mask)
		get_node("move_puzzle_1").set_collision_mask(0)
		get_node("move_puzzle_1").set_layer_mask(0)