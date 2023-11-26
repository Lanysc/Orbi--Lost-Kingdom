extends Control

@onready var main_menu = $CenterContainer/VBoxContainer/MainMenu

func _ready():
	main_menu.grab_focus()
	main_menu.pressed.connect(on_main_menu_pressed)


func on_main_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/main_menu/main_menu.tscn")
