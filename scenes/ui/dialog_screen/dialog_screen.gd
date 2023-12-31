extends Control
class_name DialogScreen

@onready var _faceset = $BackgroundColor/HBoxContainer/ColorRect/TextureRect
@onready var _name = $BackgroundColor/HBoxContainer/VBoxContainer/Name
@onready var _dialog = $BackgroundColor/HBoxContainer/VBoxContainer/Dialog
@onready var random_audio_stream_player_component = $RandomAudioStreamPlayerComponent

var _step: float = 0.05
var _id: int = 0
var data: Dictionary = {}


func _ready():
	_initialize_dialog()


func _process(_delta):
	if Input.is_action_pressed("ui_accept") and _dialog.visible_ratio < 1:
		on_enter_pressed()
		_step = 0.01
		return
	_step = 0.05
	
	if Input.is_action_just_pressed("ui_accept"):
		on_enter_pressed()
		_id += 1
		if _id >= data.size():
			queue_free()
			return
		
		_initialize_dialog()


func on_enter_pressed():
	random_audio_stream_player_component.play_random()


func _initialize_dialog():
	_name.text = data[_id]["title"]
	_dialog.text = data[_id]["dialog"]
	_faceset.texture = load(data[_id]["faceset"])
	
	_dialog.visible_characters = 0
	
	while _dialog.visible_ratio < 1:
		await get_tree().create_timer(_step).timeout
		_dialog.visible_characters += 1
