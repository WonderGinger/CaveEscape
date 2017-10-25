extends Node

onready var tiles = [get_node("NW"), get_node("N"), get_node("NE"), 
					 get_node("W"), get_node("C"), get_node("E"), 
					 get_node("SW"), get_node("S"), get_node("SE")]
onready var areas = []
var translate = {'0': [0,0], '1': [0,1], '2': [0,2],
				 '3': [1,0], '4': [1,1], '5': [1,2],
				 '6': [2,0], '7': [2,1], '8': [2,2]}
var board = []
var movecount = 0
var ai_next_move = []

func _ready():
	set_process(true)
	for x in range(3):
		board.append([])
		for y in range(3):
			board[x].append(0)
	var tile_index = 0
	for x in range(3):
		areas.append([])
		for y in range(3):
			areas[x].append(tiles[tile_index])
			tile_index += 1
	print(areas)

func player_move(element):
	for i in range(9):
		if element == tiles[i] && movecount < 9:
			var t = translate[String(i)]
			if(!place(t[0], t[1], 1)):
				ai_turn()
			else: get_node("/root/globals").goto_scene(globals.cave_2)
			break

func ai_turn():
	while true:
		randomize()
		var index = randi()%9
		if tiles[index].placeable:
#			print("ai next move: %s" % [ai_next_move])
			if ai_next_move.size() != 0:
				place(ai_next_move[0],ai_next_move[1], -1)
			else: 
				var t = translate[String(index)]
				place(t[0], t[1], -1)
		break

# state should be passed 1 for X, -1 for O, returns whether 
func place(x,y , state):
	movecount += 1
	board[x][y] = state
	if state == -1:
		areas[x][y].ai_move()
	return check_winner(x, y, state)

# state should be passed 1 for X, -1 for O
func check_winner(x, y, state):
	#columns
	print("Move: (%s, %s)" % [x, y])
	print("COLUMNS")
	for i in range(3):
		print("Checking board[%s][%s] for %s, found: %s" % [i,y,state,board[i][y]])
		if board[i][y] != state:
			break
		if i == 1:
			ai_next_move = [i+1, y]
			print("ai's next move will be at ", ai_next_move)
		if i == 2:
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
				print("won in column %s" % 2-i)
				return true
	
	#draw
	if movecount == 9:
		print("DRAW")
		return true
	return false