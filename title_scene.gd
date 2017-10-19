extends TextureFrame

func _ready():
	set_process_input(true)


func _input(event):
	if(event.type == InputEvent.KEY || event.type == InputEvent.MOUSE_BUTTON):
		get_node("/root/globals").setScene("res://container.tscn")