extends CharacterBody2D

enum State {
	IDLE,
	RUN,
	JUMP,
	FALL
}

@export var max_jumps: int = 1

@onready var visuals = $Visuals
@onready var velocity_component = $VelocityComponent
@onready var animation_player = $AnimationPlayer
@onready var interact_area = %InteractArea
@onready var danger_area = $DangerArea

var jump_count: int = 0
var current_state: State = State.IDLE
var current_weapon
var picked_box: CharacterBody2D
var boxes_in_area = []


func _ready():
	interact_area.body_entered.connect(on_interact_area_entered)
	interact_area.body_exited.connect(on_interact_area_exited)
	danger_area.body_entered.connect(on_danger_area_entered)


func _process(_delta):
	var movement_x_vector = get_input_velocity()
	verify_vertical_input()
	velocity_component.accelerate_in_direction_with_gravity(movement_x_vector)
	velocity_component.move(self)
	handle_state(movement_x_vector)
	handle_interact()


func handle_state(movement_x_vector: float):
	match current_state:
		State.IDLE:
			handle_idle(movement_x_vector)
		State.RUN:
			handle_run(movement_x_vector)
		State.JUMP:
			handle_jump()
		State.FALL:
			handle_fall()
	update_visuals(movement_x_vector)
#	update_animation()


func on_interact_area_entered(body):
	if body.is_in_group("box"):
		boxes_in_area.append(body)


func on_interact_area_exited(body):
	if body.is_in_group("box"):
		boxes_in_area.erase(body)


func on_danger_area_entered(_body):
	restart_level()


func restart_level():
	get_tree().reload_current_scene()


func handle_interact():
	if Input.is_action_just_pressed("interact"):
		if !boxes_in_area.is_empty() and picked_box == null:
			picked_box = boxes_in_area.front()
			picked_box.change_state()
		elif picked_box != null:
			picked_box.movement_x = get_input_velocity()
			picked_box.change_state()
			picked_box = null


func handle_idle(movement_x_vector: float):
	if movement_x_vector != 0:
		current_state = State.RUN
	elif not is_on_floor():
		current_state = State.FALL


func handle_run(movement_x_vector: float):
	if movement_x_vector == 0:
		current_state = State.IDLE
	elif not is_on_floor():
		current_state = State.FALL


func handle_jump():
	if is_on_floor():
		current_state = State.IDLE
	elif velocity.y > 0:
		current_state = State.FALL


func handle_fall():
	if is_on_floor():
		current_state = State.IDLE


func update_visuals(movement_x_vector: float):
	if movement_x_vector != 0:
		visuals.scale.x = -sign(movement_x_vector)


func update_animation():
	match current_state:
		State.IDLE:
			animation_player.play("idle")
		State.RUN:
			animation_player.play("run")
		State.JUMP:
			animation_player.play("jump")
		State.FALL:
			animation_player.play("fall")


func verify_vertical_input():
	if is_on_floor():
		jump_count = 0
	if Input.is_action_just_pressed("jump") and jump_count < max_jumps:
		current_state = State.JUMP
		jump_count += 1
		velocity_component.jump()


func get_input_velocity() -> float:
	var horizontal = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	return horizontal
