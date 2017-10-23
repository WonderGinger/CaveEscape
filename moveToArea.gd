extends Area2D

#You can set this variable by clicking on moveToArea under Inspector.
export var sceneToMove = ""

#When the player reaches the first area, they are moved to puzzle_1
func _on_moveToArea_body_enter( body ):
	var path = ""
	if(sceneToMove != ""): path = sceneToMove
	else: path = globals.title_screen
	get_node("/root/globals").goto_scene(path)
