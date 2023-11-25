extends CharacterBody2D

@export var gate: Gate
@export var is_resettable := true
@onready var area_2d = $Area2D
@onready var animation_player = $AnimationPlayer

var bodies_number := 0

func _ready():
	bodies_number = 0
	area_2d.body_entered.connect(on_body_entered)
	area_2d.body_exited.connect(on_body_exited)


func on_body_entered(_body: Node2D):
	if bodies_number == 0:
		if gate:
			gate.open()
		animation_player.play("press")
	bodies_number += 1


func on_body_exited(_body: Node2D):
	if !is_resettable:
		return
	
	bodies_number -= 1
	if bodies_number <= 0:
		animation_player.play("unpress")
		
		if gate:
			gate.close()
