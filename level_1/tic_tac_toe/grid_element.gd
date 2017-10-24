extends Area2D

var placeable = true
var player = null

func _ready():
	set_process(true)
	connect("body_enter", self, "on_body_enter")

func _process(delta):
	if Input.is_action_pressed("player_interact") && can_place_piece(player, self): 
		get_node("piece").set_animation("O_piece")
		placeable = false

func can_place_piece(char, item):
  # char and item are Nodes
	if char:
		if char.get_global_pos().distance_to(item.get_global_pos()) <= 20:
			return placeable
	return false

func on_body_enter( body ):
	player = body