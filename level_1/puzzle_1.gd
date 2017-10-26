extends Node

onready var tiles = [get_node("NW"), get_node("N"), get_node("NE"), 
					 get_node("W"), get_node("C"), get_node("E"), 
					 get_node("SW"), get_node("S"), get_node("SE")]
var translate = {'0': [0,0], '1': [0,1], '2': [0,2],
				 '3': [1,0], '4': [1,1], '5': [1,2],
				 '6': [2,0], '7': [2,1], '8': [2,2]}
var board = []
var movecount = 0

func _ready():
	set_process(true)
	for x in range(3):
		board.append([])
		for y in range(3):
			board[x].append(0)

func _process(delta):
	if Input.is_action_pressed("player_interact"):
		get_node("Hint/Label").hide()

func player_move(element):
	for i in range(9):
		if element == tiles[i] && movecount < 9:
			if(!place(i, 1)):
				ai_turn()
			else: get_node("/root/globals").goto_scene(globals.cave_2)
			break

func ai_turn():
	while true:
		randomize()
		var rand_index = randi()%9
		if tiles[rand_index].placeable:
			tiles[rand_index].ai_move()
			place(rand_index, -1)
			break

# state should be passed 1 for X, -1 for O, returns whether 
func place(index, state):
	movecount += 1
	var t = translate[String(index)]
	board[t[0]][t[1]] = state
	return check_winner(t[0], t[1], state)

# state should be passed 1 for X, -1 for O
func check_winner(x, y, state):
	#columns
	print("Move: (%s, %s)" % [x, y])
	print("COLUMNS")
	for i in range(3):
		print("Checking board[%s][%s] for %s, found: %s" % [i,y,state,board[i][y]])
		if board[i][y] != state:
			break
		if(i == 2):
			return true
	
	#rows
	print("ROWS")
	for i in range(3):
		print("Checking board[%s][%s] for %s, found: %s" % [y,i,state,board[y][i]])
		if board[x][i] != state:
			break
		if i == 2:
			return true
	
	#diag
	print("DIAG")
	if(x == y):
		for i in range(3):
			print("Checking board[%s][%s] for %s, found: %s" % [i,i,state,board[i][i]])
			if board[i][i] != state:
				break
			if i == 2:
				return true
	
	#antidiag
	print("ANTIDIAG")
	if(x + y == 2):
		for i in range(3):
			print("Checking board[%s][%s] for %s, found: %s" % [i,2-i,state,board[i][2-i]])
			if board[i][2-i] != state:
				break
			if i == 2:
				return true
	
	#draw
	if movecount == 9:
		print("DRAW")
		return true
	return false