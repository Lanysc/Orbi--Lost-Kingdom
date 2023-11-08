extends Camera2D

@export var h_margin: int = 100 #Horizontal Margin
@export var v_margin: int = 100 #Vertical Margin
@export var cam_speed: float = 0.05 #Camera Speed

var margin
var target_position = Vector2.ZERO

func _ready():
	margin = Vector2(h_margin, v_margin)
	make_current()


func _physics_process(_delta):
	acquire_target()
	global_position = global_position.lerp(target_position, cam_speed)
	pass


func acquire_target():
	var player_nodes = get_tree().get_nodes_in_group("player")
	if player_nodes.size() > 0:
		var player = player_nodes[0] as Node2D
		offset = player.global_position - global_position
		
		# Atualiza a posição alvo se o jogador ultrapassar a margem em x ou y.
		if abs(offset.x) > margin.x:
			target_position.x = global_position.x + offset.x - sign(offset.x) * margin.x
		else:
			target_position.x = global_position.x
		
		if abs(offset.y) > margin.y:
			target_position.y = global_position.y + offset.y - sign(offset.y) * margin.y
		else:
			target_position.y = global_position.y
