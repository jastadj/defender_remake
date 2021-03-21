extends KinematicBody2D

var vel = Vector2(25,0)
#var vel = Vector2(10,0)
var camera
var player

func _ready():
	camera = get_tree().root.get_node("game/Camera2D")
	player = get_tree().root.get_node("game/player")
	
func _physics_process(delta):
	
	move_and_collide(vel)

	if position.x > camera.position.x + get_viewport_rect().size.x: queue_free()
	elif position.x < camera.position.x - get_viewport_rect().size.x: queue_free()

func flip():
	vel.x *= -1
	$Particles2D.rotation = PI
