extends Node2D

@export var end_screen_scene:PackedScene

var pause_menu_scene = preload("res://scenes/ui/pause_menu/pause_menu.tscn")


func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		get_parent().add_child(pause_menu_scene.instantiate())
		get_tree().root.set_input_as_handled()
