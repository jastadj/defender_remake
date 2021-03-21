extends KinematicBody2D

var vel = Vector2(50,0)
var camera
var player

func _ready():
	camera = get_tree().root.get_node("game/Camera2D")
	player = get_tree().root.get_node("game/player")
	
func _physics_process(delta):
	
	move_and_collide(vel)

	if position.x > camera.position.x + get_viewport_rect().size.x: queue_free()
	elif position.x < camera.position.x - get_viewport_rect().size.x: queue_free()
