extends CharacterBody2D

@export var is_picked_up = false

@onready var velocity_component = $VelocityComponent
@onready var collision_shape_2d = $CollisionShape2D
@onready var area_2d = $Area2D

var movement_x:= 0.0

func _ready():
	area_2d.body_exited.connect(on_body_exited)

func _process(_delta):
	if is_picked_up:
		var player = get_tree().get_first_node_in_group("player")
		set_deferred("global_position", player.global_position)
	else:
		velocity_component.accelerate_in_direction_with_gravity(movement_x)
		handle_velocity()
		velocity_component.move(self)


func on_body_exited(body: Node2D):
	if !is_picked_up:
		set_collision_layer_value(4, true)
		set_collision_layer_value(3, false)


func handle_velocity():
	if movement_x == 0.0:
		return
	if movement_x > 0:
		movement_x = max(movement_x - 0.04, 0.0)
	elif movement_x < 0:
		movement_x = min(movement_x + 0.04, 0.0)


func change_state():
	set_collision_layer_value(4, false)
	
	is_picked_up = !is_picked_up
	
	set_collision_layer_value(3, true)
	
	
