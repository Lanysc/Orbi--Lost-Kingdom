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
	}
}

@onready var area_2d = $Area2D

var _new_dialog: DialogScreen
var _player_inside:= false

func _ready():
	area_2d.body_entered.connect(on_body_entered)
	area_2d.body_exited.connect(on_body_exited)

func _process(delta):
	if Input.is_action_pressed("interact") and _player_inside:
		_new_dialog = dialog_screen.instantiate()
		_new_dialog.name = "DialogScreen"  # Define um nome para o nó
		_new_dialog.data = data
		hud.add_child(_new_dialog)

 
func on_body_entered(body: Node2D):
	_player_inside = true


func on_body_exited(body: Node2D):
	_player_inside = false
	# Itera sobre todos os filhos de 'hud' e os remove
	if hud.get_children().size() > 0:
		for child in hud.get_children():
			child.queue_free()

