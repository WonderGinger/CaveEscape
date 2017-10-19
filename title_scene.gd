extends TextureFrame

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	if(Input.is_mouse_button_pressed(BUTTON_LEFT)):
		get_node("/root/globals").setScene("res://container.tscn")