extends KinematicBody2D

var SHIP_SPEED = Vector2(5000,5000)
var MAX_ACCELERATION = Vector2(100,100)
var MAX_VELOCITY = Vector2(800,500)
var DECELERATION = Vector2(5,50)

var velocity = Vector2()
var acceleration = Vector2()

var flipped = false
var MAX_CAMERA_OFFSET = 250
var CAMERA_PAN_SPEED = 0.75

func _ready():
	$Camera2D.position.x = MAX_CAMERA_OFFSET
	
func _physics_process(delta):
	
	var move_dir = Vector2()
	var viewport_size = get_viewport_rect().size
	
	# get player move input
	if Input.is_action_pressed("ui_up"): move_dir.y -= 1
	if Input.is_action_pressed("ui_down"): move_dir.y += 1
	if Input.is_action_pressed("ui_left"): move_dir.x -= 1
	if Input.is_action_pressed("ui_right"): move_dir.x += 1
	
	# flip player sprite if moving left
	if $Sprite.flip_h and move_dir.x > 0: $Sprite.flip_h = false
	elif !$Sprite.flip_h and move_dir.x < 0: $Sprite.flip_h = true
	
	# update acceleration
	acceleration = move_dir * SHIP_SPEED * delta
	acceleration.x = clamp(acceleration.x, -MAX_ACCELERATION.x, MAX_ACCELERATION.x)
	acceleration.y = clamp(acceleration.y, -MAX_ACCELERATION.y, MAX_ACCELERATION.y)
	
	# update velocity
	velocity += acceleration
	velocity.x = clamp(velocity.x, -MAX_VELOCITY.x, MAX_VELOCITY.x)
	velocity.y = clamp(velocity.y, -MAX_VELOCITY.y, MAX_VELOCITY.y)	
	
	# decel in axis that isn't being thrusted
	if velocity.x != 0 and move_dir.x == 0:
		var decel = abs(velocity.x) - DECELERATION.x
		if decel <= 0: velocity.x = 0
		else:
			if velocity.x < 0: decel = decel * -1
			velocity.x = decel
	if velocity.y != 0 and move_dir.y == 0:
		var decel = abs(velocity.y) - DECELERATION.y
		if decel <= 0: velocity.y = 0
		else:
			if velocity.y < 0: decel = decel * -1
			velocity.y = decel
			
	move_and_slide(velocity)
	
	if position.y < 0: position.y = 0
	elif position.y >= viewport_size.y: position.y = viewport_size.y
	
	# set camera position
	update_camera(delta)

func _input(event):
	
	if event.is_action_pressed("ui_shoot"): shoot()
	elif event.is_action_pressed("ui_cancel"): get_tree().quit()

func update_camera(delta):
	var direction_changed = false
	var global_y = to_local( Vector2(get_viewport().size.x, get_viewport().size.y/2) ).y
	# has player flipped directions?
	if !flipped and $Sprite.flip_h:
		direction_changed = true
		flipped = true
	elif flipped and !$Sprite.flip_h:
		direction_changed = true
		flipped = false
	
	$Camera2D.position.y = global_y
	
	# if player changed directions, tween the camera across the screen
	if direction_changed:
		var dir_mod = 1
		if flipped: dir_mod = -1
		$camera_tween.interpolate_property($Camera2D, "position",
			Vector2($Camera2D.position), Vector2(MAX_CAMERA_OFFSET*dir_mod, $Camera2D.position.y),
			1*CAMERA_PAN_SPEED, Tween.TRANS_CUBIC, Tween.EASE_OUT)
		$camera_tween.start()

func shoot():
	
	var new_projectile = preload("res://player/player_projectile.tscn").instance()
	var shoot_sound = preload("res://sounds/player_shoot_sound.tscn").instance()
	
	shoot_sound.play()
	add_child(shoot_sound)
	
	# spawn the projectile at the gun position node
	var spawn_pos = $gun_pos.global_position
	# if player sprite is flipped, shoot/spawn x-axis flip
	if $Sprite.flip_h:
		spawn_pos.x -= $gun_pos.position.x*2
		new_projectile.flip()
	
	new_projectile.position = spawn_pos
	get_tree().root.get_node("game").add_child(new_projectile)
