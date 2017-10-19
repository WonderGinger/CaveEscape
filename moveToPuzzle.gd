extends Area2D

export var sceneToMove = ""
 
func _on_Area2D_body_enter(body):
	setScene("puzzle1.tscn")