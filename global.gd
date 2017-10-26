extends Node

var current_scene = null
var cave_1 = "res://level_1/cave_1.tscn"
var cave_2 = "res://level_2/cave_2.tscn"
var puzzle_1 = "res://level_1/puzzle_1.tscn"
var puzzle_1_complete = false
var title_screen = "res://title_screen/title_screen.tscn"

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child( root.get_child_count() -1 )

func goto_scene(path):
    call_deferred("_deferred_goto_scene",path)


func _deferred_goto_scene(path):

    # Immediately free the current scene,
    # there is no risk here.
    current_scene.free()

    # Load new scene
    var s = load(path)

    # Instance the new scene
    current_scene = s.instance()

    # Add it to the active scene, as child of root
    get_tree().get_root().add_child(current_scene)

    # optional, to make it compatible with the SceneTree.change_scene() API
    get_tree().set_current_scene(current_scene)