extends KinematicBody2D

const MAX_MOVE_SPEED = 5
const MAX_VECTOR_LENGTH = 20
const VECTOR_INCREMENT = .5
var speed = 1

func _fixed_process(delta):
	var move_direction = Vector2(0,0)
	var dpad = { 
	'left':Input.is_action_pressed("player_move_left"), 
	'right':Input.is_action_pressed("player_move_right"),
	'up':Input.is_action_pressed("player_move_up"),
	'down':Input.is_action_pressed("player_move_down") 
	}
	var key_pressed = dpad['left'] || dpad['right'] || dpad['up'] || dpad['down']
		
	if dpad['left'] && move_direction.x > -MAX_VECTOR_LENGTH:
		move_direction += Vector2(-1,0)
	if dpad['right'] && move_direction.x < MAX_VECTOR_LENGTH:
	    move_direction += Vector2(1,0)
	if dpad['up'] && move_direction.y < MAX_VECTOR_LENGTH:
	    move_direction += Vector2(0,-1)
	if dpad['down'] && move_direction.y > -MAX_VECTOR_LENGTH:
		move_direction += Vector2(0,1)
	
#	if(key_pressed):
#		if speed < MAX_MOVE_SPEED: speed += .1
#	else: 
#		if speed > 0: speed -= .1
#		else: move_direction = Vector2(0,0)
	move(move_direction.normalized() * MAX_MOVE_SPEED)
#	move_direction += inc_vector_towards_zero(move_direction)

func inc_vector_towards_zero(vector):
	var result = Vector2(0,0)
	if vector.x > 0: result += Vector2(-VECTOR_INCREMENT,0)
	elif vector.x < 0: result += Vector2(VECTOR_INCREMENT,0)
	elif vector.y > 0: result += Vector2(0,-VECTOR_INCREMENT)
	elif vector.y < 0: result += Vector2(0,VECTOR_INCREMENT)
	return result

func _ready():
	set_fixed_process(true)