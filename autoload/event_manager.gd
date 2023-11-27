extends Node
class_name Event

@export var level_changed:= true

@onready var die_fx = $DieFx

func change_level():
	level_changed = true


func level_restart():
	level_changed = false
	die_fx.play()
	get_tree().reload_current_scene()
