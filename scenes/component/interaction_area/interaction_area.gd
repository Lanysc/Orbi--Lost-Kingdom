extends Area2D

signal player_interact
signal player_entered
signal player_exited

var player_inside: bool = false

func _ready():
	self.body_entered.connect(_on_body_entered)
	self.body_exited.connect(_on_body_exited)


func _process(delta):
	if player_inside and Input.is_action_just_pressed("interact"):
		emit_signal("player_interact")


func _on_body_entered(body: Node2D):
	if body.is_in_group("player"):
		player_entered.emit()
		player_inside = true


func _on_body_exited(body: Node2D):
	if body.is_in_group("player"):
		player_exited.emit()
		player_inside = false
