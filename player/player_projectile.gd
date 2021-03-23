extends KinematicBody2D

var TRACER_SCALE_SPEED = 0.02
var TRACER_MAX_SCALE = 40
var PROJECTILE_VELOCITY = 30

var vel
var camera
var player
var time_alive
var flipped = false

func _ready():
	player = get_tree().root.get_node("game/player")
	camera = player.get_node("Camera2D")
	time_alive = OS.get_ticks_msec()
	
func _physics_process(delta):
	
	# keep projectile velocity constantly relative to player velocity, not realistic
	# but players better
	vel = Vector2(PROJECTILE_VELOCITY + abs(player.velocity.x) * delta, 0)
	if flipped: vel *= -1
	
	move_and_collide(vel)

	if position.x > camera.to_global(camera.position).x + get_viewport_rect().size.x: queue_free()
	elif position.x < camera.to_global(camera.position).x - get_viewport_rect().size.x: queue_free()

	$tracer.scale.x += (OS.get_ticks_msec() - time_alive)*TRACER_SCALE_SPEED
	if $tracer.scale.x > TRACER_MAX_SCALE:
		$tracer.scale.x = TRACER_MAX_SCALE
	$tracer.position.x = (-$tracer.scale.x*2)-2
	
	$tracer.self_modulate = Gamedata.rotating_palette.color

func flip():
	flipped = true
	#vel.x *= -1
	#$Particles2D.rotation = PI
