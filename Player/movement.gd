extends KinematicBody2D

const MAX_MOVE_SPEED = 5
onready var ghost = get_node("ghost")
var facing_down = true

func _fixed_process(delta):
	var move_direction = Vector2(0,0)
	var dpad = { 
	'left':Input.is_action_pressed("player_move_left"), 
	'right':Input.is_action_pressed("player_move_right"),
	'up':Input.is_action_pressed("player_move_up"),
	'down':Input.is_action_pressed("player_move_down") 
	}
	var key_pressed = dpad['left'] || dpad['right'] || dpad['up'] || dpad['down']

	if dpad['left']:
		ghost.set_animation("move_left")
		move_direction += Vector2(-1,0)
	if dpad['right']:
		ghost.set_animation("move_right")
		move_direction += Vector2(1,0)
	if dpad['up']:
		facing_down = false
		ghost.set_animation("move_up")
		move_direction += Vector2(0,-1)
	if dpad['down']:
		facing_down = true
		ghost.set_animation("move_down")
		move_direction += Vector2(0,1)
	if(!key_pressed):
		if(facing_down): ghost.set_animation("default")
		else: ghost.set_animation("idle_back")
	move(move_direction.normalized() * MAX_MOVE_SPEED)

func _ready():
	set_fixed_process(true)