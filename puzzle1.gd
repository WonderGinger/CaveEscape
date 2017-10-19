extends Area2D

#You can set this variable by clicking on moveToArea under Inspector.
export var sceneToMove = ""

#When the player reaches the first area, they are moved to the first level.
func _on_moveToArea_body_enter( body ):
	get_node("/root/globals").goto_scene("container.tscn")