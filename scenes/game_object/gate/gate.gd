extends StaticBody2D
class_name Gate

@export var is_closed:= true

@onready var collision_shape_2d = $CollisionShape2D
@onready var sprite_2d = $Sprite2D


func open():
	is_closed = true
	change_state()

func close():
	is_closed = false
	change_state()


func change_state():
	collision_shape_2d.set_deferred("disabled", is_closed)
	sprite_2d.set_deferred("visible", !is_closed)
