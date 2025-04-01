extends Control

func _ready():
    Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func level_1():
    get_tree().change_scene_to_file("res://test_map.tscn")

func level_2():
    get_tree().change_scene_to_file("res://seesaw.tscn")

func exit():
    get_tree().quit()
