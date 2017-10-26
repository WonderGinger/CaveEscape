extends Area2D

#You can set this variable by clicking on moveToArea under Inspector.
export var sceneToMove = ""
func _ready():
	connect("body_enter", self, "on_body_enter")
#When the player reaches the first area, they are moved to puzzle_1
func on_body_enter( body ):
	var path = ""
	if(sceneToMove != ""): path = sceneToMove
	else: path = globals.title_screen
	get_node("/root/globals").goto_scene(path)