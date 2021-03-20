extends KinematicBody2D

var SHIP_SPEED = 5000
var MAX_ACCELERATION = 100
var MAX_VELOCITY = 1000


var velocity = Vector2()
var acceleration = Vector2()


func _physics_process(delta):
	
	var move_dir = Vector2()
	
	# get player move input
	if Input.is_action_pressed("ui_up"): move_dir.y -= 1
	if Input.is_action_pressed("ui_down"): move_dir.y += 1
	if Input.is_action_pressed("ui_left"): move_dir.x -= 1
	if Input.is_action_pressed("ui_right"): move_dir.x += 1
	
	# update acceleration
	acceleration = move_dir * SHIP_SPEED * delta
	acceleration.x = clamp(acceleration.x, -MAX_ACCELERATION, MAX_ACCELERATION)
	acceleration.y = clamp(acceleration.y, -MAX_ACCELERATION, MAX_ACCELERATION)
	
	# update velocity
	velocity += acceleration
	velocity.x = clamp(velocity.x, -MAX_VELOCITY, MAX_VELOCITY)
	velocity.y = clamp(velocity.y, -MAX_VELOCITY, MAX_VELOCITY)	
	
	move_and_slide(velocity)
