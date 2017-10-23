extends TextureFrame

var can_start = false

func _ready():
	set_process_input(true)
	var t = Timer.new()
	t.set_one_shot(true)
	t.set_wait_time(2)
	t.connect("timeout", self, "_on_timeout_complete")
	add_child(t)
	t.start()

func _input(event):
	if(can_start && event.type == InputEvent.KEY || event.type == InputEvent.MOUSE_BUTTON):
		get_node("/root/globals").goto_scene(globals.cave_1)

func _on_timeout_complete():
	can_start = true