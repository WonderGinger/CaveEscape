extends Area2D

var placeable = true
var player = null

func _ready():
	set_process(true)
	connect("body_enter", self, "on_body_enter")

func _process(delta):
	if Input.is_action_pressed("player_interact") && can_place_piece(player, self): 
		get_node("piece").set_animation("X_piece")
		get_parent().player_turn(self)
		placeable = false

func can_place_piece(char, item):
	if char:
		if char.get_global_pos().distance_to(item.get_global_pos()) <= 40:
			return placeable
	return false

func ai_move():
	get_node("piece").set_animation("O_piece")

func on_body_enter( body ):
	player = body