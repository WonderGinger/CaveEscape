extends Area2D

var placeable = true
var body_inside = false
var position = [0,0]

func _ready():
	set_process(true)
	connect("body_enter", self, "on_body_enter")
	connect("body_exit", self, "on_body_exit")

func _process(delta):
	if Input.is_action_pressed("player_interact") && can_place_piece():
		player_move()

func can_place_piece():
	if body_inside:
		return placeable
	return false

func player_move():
		set_animation("X")
		placeable = false
		get_parent().player_move(self)

func ai_move():
	set_animation("O")
	placeable = false

func set_animation(type):
	if type == "default": 
		get_node("piece").set_animation(type)
	else: 
		get_node("piece").set_animation(type+"_piece")

func on_body_enter( body ):
	body_inside = placeable

func on_body_exit(body):
	body_inside = false

func _on_Area2D_body_enter(body):
	body_inside = placeable