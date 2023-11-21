extends Node2D

@export_category("Objects")
@export var hud: CanvasLayer
@export var dialog_screen: PackedScene = preload("res://scenes/component/dialog_screen/dialog_screen.tscn")

@export_category("Data")
@export var data: Dictionary = {
	0: {
		"faceset": "res://icon.svg",
		"dialog": "Hmm, Parece que leva para o Nivel X",
		"title": "Orbi"
	},
	1: {
		"faceset": "res://icon.svg",
		"dialog": "Hmm, Parece que leva para o Nivel X",
		"title": "Orbi"
	},
	2: {
		"faceset": "res://icon.svg",
		"dialog": "Hmm, Parece que leva para o Nivel X",
		"title": "Orbi"
	},
	3: {
		"faceset": "res://icon.svg",
		"dialog": "Hmm, Parece que leva para o Nivel X",
		"title": "Orbi"
	},
	4: {
		"faceset": "res://icon.svg",
		"dialog": "Hmm, Parece que leva para o Nivel X",
		"title": "Orbi"
	},
	5: {
		"faceset": "res://icon.svg",
		"dialog": "Hmm, Parece que leva para o Nivel X",
		"title": "Orbi"
	},
}

@onready var area_2d = $Area2D

var _new_dialog: DialogScreen
var _already_played:= false

func _ready():
	area_2d.body_entered.connect(on_body_entered)
 

func on_body_entered(_body: Node2D):
	if _already_played:
		return
	_already_played = true
	_new_dialog = dialog_screen.instantiate()
	_new_dialog.name = "DialogScreen"  # Define um nome para o nó
	_new_dialog.data = data
	hud.add_child(_new_dialog)

