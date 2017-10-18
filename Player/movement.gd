extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const MAX_MOVE_SPEED = 5
var speed = 1

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)
#	set_process(true)
#	set_process_input(true)
#	print(self)

func _fixed_process(delta):
	var move_direction = Vector2(0,0)
	
	var dpad_left = Input.is_action_pressed("player_move_left")
	var dpad_right = Input.is_action_pressed("player_move_right")
	var dpad_up  = Input.is_action_pressed("player_move_up")
	var dpad_down = Input.is_action_pressed("player_move_down")
	
	if dpad_left:
		move_direction += Vector2(-1,0)
	if dpad_right:
	    move_direction += Vector2(1,0)
	if dpad_up:
	    move_direction += Vector2(0,-1)
	if dpad_down:
	    move_direction += Vector2(0,1)
	move(move_direction.normalized() * speed)
	if speed < MAX_MOVE_SPEED: speed += 1