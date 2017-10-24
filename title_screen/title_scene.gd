extends TextureFrame

var allow_start = false
onready var animation = get_node("title_text/Animation")

func _ready():
	set_process_input(true)
	var t = Timer.new()
	t.set_one_shot(true)
	t.set_wait_time(2)
	t.connect("timeout", self, "_on_timeout_complete")
	add_child(t)
	t.start()

func _input(event):
	if(allow_start && event.type == InputEvent.KEY || event.type == InputEvent.MOUSE_BUTTON):
		get_node("/root/globals").goto_scene(globals.cave_1)

func _on_timeout_complete():
	allow_start = true
	animation.play("OpacityAnimation")