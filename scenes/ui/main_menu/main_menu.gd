extends Control

@export var options_scene: PackedScene

@onready var start_button = $VBoxContainer/StartButton
@onready var level_selector_button = $VBoxContainer/LevelSelectorButton
@onready var options_button = $VBoxContainer/OptionsButton
@onready var quit_button = $VBoxContainer/QuitButton

var _first_level_path = "res://scenes/main/level_tester.tscn"
var _level_selector_path = "res://scenes/main/level_selector_tester.tscn"


func _ready():
	start_button.grab_focus()
	start_button.pressed.connect(on_start_button_pressed)
	level_selector_button.pressed.connect(on_level_selector_button_pressed)
	options_button.pressed.connect(on_options_button_pressed)
	quit_button.pressed.connect(on_quit_button_pressed)

func on_start_button_pressed():
	get_tree().change_scene_to_file(_first_level_path)


func on_level_selector_button_pressed():
	get_tree().change_scene_to_file(_level_selector_path)


func on_options_button_pressed():
	var options_instance = options_scene.instantiate()
	add_child(options_instance)
	options_instance.back_pressed.connect(on_options_closed.bind(options_instance))


func on_quit_button_pressed():
	get_tree().quit()


func on_options_closed(options_instance: Node):
	options_instance.queue_free()
