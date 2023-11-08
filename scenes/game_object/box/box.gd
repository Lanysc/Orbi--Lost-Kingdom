extends CharacterBody2D

@export var is_picked_up = false

@onready var velocity_component = $VelocityComponent

var movement_x:= 0.0

func _process(_delta):
	if is_picked_up:
		var player = get_tree().get_first_node_in_group("player")
		global_position = player.global_position
	else:
		velocity_component.accelerate_in_direction_with_gravity(movement_x)
		handle_velocity()
		velocity_component.move(self)


func handle_velocity():
	if movement_x == 0.0:
		return
	if movement_x > 0:
		movement_x = max(movement_x - 0.04, 0.0)
	elif movement_x < 0:
		movement_x = min(movement_x + 0.04, 0.0)


func change_state():
	is_picked_up = !is_picked_up
