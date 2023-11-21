extends Node2D

@export var level_path := "res://scenes/main/level_4.tscn"
@export var automatic := true

@onready var area_2d = $Area2D
@onready var timer = Timer.new()  # Criar um novo Timer

var player_inside := false
var camera_2d : Camera2D
var shaking_duration := 0.5  # Duração do shake em segundos
var shaking_intensity := 5  # Intensidade do shake
var original_offset
var in_progress:= false

func _ready():
	camera_2d = get_parent().get_node("Camera2D")
	original_offset = camera_2d.offset
	area_2d.body_entered.connect(_on_Area2D_body_entered)
	area_2d.body_exited.connect(_on_Area2D_body_exited)
	timer.wait_time = shaking_duration
	timer.one_shot = true
	add_child(timer)
	timer.timeout.connect(_on_Timer_timeout)


func _process(_delta):
	if player_inside and (Input.is_key_pressed(KEY_W) or automatic):
		if !in_progress:
			start_level_change()


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		player_inside = true


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		player_inside = false


func start_level_change():
	in_progress = true
	get_parent().get_node("Player").queue_free()
	timer.start()
	shake_screen()  # Iniciar o efeito de tela tremendo


func _on_Timer_timeout():
	change_level()  # Mudar de nível após 2 segundos


func change_level():
	get_tree().change_scene_to_file(level_path)


func shake_screen():
	var shake_timer = get_tree().create_timer(shaking_duration)
	while shake_timer.time_left > 0:
		camera_2d.offset = original_offset + Vector2(randf_range(-shaking_intensity, shaking_intensity), randf_range(-shaking_intensity, shaking_intensity))
		await get_tree().process_frame
	camera_2d.offset = original_offset
