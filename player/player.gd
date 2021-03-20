extends KinematicBody2D

var SHIP_SPEED = Vector2(5000,5000)
var MAX_ACCELERATION = Vector2(100,100)
var MAX_VELOCITY = Vector2(1000,1000)
var DECELERATION = 100


var velocity = Vector2()
var acceleration = Vector2()


func _physics_process(delta):
	
	var move_dir = Vector2()
	var viewport_size = get_viewport_rect().size
	
	# get player move input
	if Input.is_action_pressed("ui_up"): move_dir.y -= 1
	if Input.is_action_pressed("ui_down"): move_dir.y += 1
	if Input.is_action_pressed("ui_left"): move_dir.x -= 1
	if Input.is_action_pressed("ui_right"): move_dir.x += 1
	
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
		var decel = abs(velocity.x) - DECELERATION
		if decel <= 0: velocity.x = 0
		else:
			if velocity.x < 0: decel = decel * -1
			velocity.x = decel
	if velocity.y != 0 and move_dir.y == 0:
		var decel = abs(velocity.y) - DECELERATION
		if decel <= 0: velocity.y = 0
		else:
			if velocity.y < 0: decel = decel * -1
			velocity.y = decel
			
	move_and_slide(velocity)
	
	if position.y < 0: position.y = 0
	elif position.y >= viewport_size.y: position.y = viewport_size.y
	
