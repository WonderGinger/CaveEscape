extends KinematicBody2D

const MAX_MOVE_SPEED = 5
const MOVE_GOAL = 10
var vel_goal = Vector2(0,0)
var vel = { 'x': 0, 'y': 0 }
var print_counter = 0

func _fixed_process(delta):
	print_counter += 1
	var dpad = { 
	'left':Input.is_action_pressed("player_move_left"), 
	'right':Input.is_action_pressed("player_move_right"),
	'up':Input.is_action_pressed("player_move_up"),
	'down':Input.is_action_pressed("player_move_down") 
	}
#	var key_pressed = dpad['left'] || dpad['right'] || dpad['up'] || dpad['down']

	if dpad['left']:
	    vel_goal += Vector2(-1, 0)
	elif dpad['right']:
	    vel_goal += Vector2(1, 0)
	else: vel_goal += Vector2(-vel_goal.x, 0)
	if dpad['up']:
	    vel_goal += Vector2(0, -1)
	elif dpad['down']:
	    vel_goal += Vector2(0, 1)
	else: vel_goal += Vector2(0, -vel_goal.y)
	update(delta)
#	move(Vector2(vel['x'], vel['y']))

func update(delta):
	var new_pos = get_pos()
	vel['x'] = approach(get_pos().x, get_pos().x + vel_goal.x, delta*100)
	vel['y'] = approach(get_pos().y, get_pos().x + vel_goal.y, delta*100)
#	print(vel['x'], " | ", vel['y'])
	new_pos = Vector2(vel['x'], vel['y'])# * delta
	if(print_counter % 60 == 0):
		print("Current: ", get_pos(), "\nVel[x,y]: (", vel['x'], ", ", vel['y'], ")\nGoal: ", vel_goal)
	if(get_viewport_rect().has_point(new_pos)):
		set_pos(new_pos)

func approach(current, goal, dt):
	var difference = goal - current
	if(difference > dt):
		return current + dt
	if(difference < -dt):
		return current - dt
	return goal

func _ready():
	set_fixed_process(true)