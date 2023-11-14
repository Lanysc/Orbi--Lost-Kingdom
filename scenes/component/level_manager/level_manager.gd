extends Node2D

@export var level_path := "res://scenes/main/level_4.tscn"

@onready var area_2d = $Area2D

var player_inside := false  # Variável para acompanhar se o jogador está na área


func _ready():
	area_2d.body_entered.connect(_on_Area2D_body_entered)
	area_2d.body_exited.connect(_on_Area2D_body_exited)


func _process(delta):
	if player_inside and Input.is_key_pressed(KEY_W):  # Verifica se 'W' é pressionado
		change_level()


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):  # Substitua "player" pelo grupo correto, se necessário
		player_inside = true


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):  # Substitua "player" pelo grupo correto, se necessário
		player_inside = false


func change_level():
	get_tree().change_scene_to_file(level_path)
