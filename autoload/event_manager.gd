extends Node
class_name Event

@export var level_changed:= true


func change_level():
	level_changed = true


func level_restart():
	level_changed = false
	get_tree().reload_current_scene()
