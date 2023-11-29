extends CharacterBody2D

enum State {
	AIR,
	FALL,
	GROUND
}

@export var is_picked_up = false

@onready var velocity_component = $VelocityComponent
@onready var collision_shape_2d = $CollisionShape2D
@onready var area_2d = $Area2D
@onready var area_2d_2 = $Area2D2
@onready var drop_fx = $DropFx

var movement_x:= 0.0
var is_rigid := true
var current_state: State = State.GROUND
var is_player_below: = false

func _ready():
	area_2d.body_exited.connect(on_body_exited)
	area_2d_2.body_entered.connect(on_player_die)


func _process(_delta):
	if velocity_component.velocity.y == Vector2.ZERO.y and current_state == State.AIR:
		drop_fx.play()
	
	if is_picked_up:
		current_state = State.AIR
		var player = get_tree().get_first_node_in_group("player")
		set_deferred("global_position", player.global_position)
	else:
		velocity_component.accelerate_in_direction_with_gravity(movement_x)
		handle_velocity()
		velocity_component.move(self)
	
	if is_player_below:
		verify_player_below()


func on_body_exited(_body: Node2D):
	if _body.is_in_group("player"):
		is_player_below = false
	if !is_picked_up:
		set_collision_layer_value(4, true)
		set_collision_layer_value(3, false)
		is_rigid = true


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
	is_rigid = false
	set_collision_layer_value(3, true)


func on_player_die(_body: Node2D):
	if _body.is_in_group("player"):
		is_player_below = true


func verify_player_below():
	if is_rigid and velocity_component.velocity != Vector2.ZERO:
			EventManager.level_restart()
