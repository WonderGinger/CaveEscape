extends Node

# http://mathforum.org/alejandre/magic.square/adler/adler.whatsquare.html
# Used to calculate whether someone won.
var magic_square = {
	'1': 8, '2': 1, '3': 6,
	'4': 3, '5': 5, '6': 7,
	'7': 4, '8': 9, '9': 2
}
var tictactoe = {
	'NW': false, 
	'N': false,
	'NE': false, 
	'W': false, 
	'C': false,
	'E': false,
	'SW': false,
	'S': false, 
	'SE': false
}
var movecount = 0

func _ready():
	set_process(true)

func player_turn(element):
	tictactoe[element.get_name()] = true
	movecount += 1
	if(movecount < 9):
		get_node(ai_turn()).ai_move()

#returns the name of the tic tac toe grid that an X was placed on.
func ai_turn():
	for i in tictactoe:
		if(tictactoe[i] == false):
			tictactoe[i] = true
			movecount += 1
			return i

