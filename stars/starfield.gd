extends CanvasLayer

var parallax_x_amount = 0.05
var max_stars = 50

var camera
var view_size
var stars

func _ready():
	
	camera = get_tree().root.get_node("game/Camera2D")
	view_size = camera.get_viewport_rect().size
	stars = $Area2D/stars
	
	$Area2D/CollisionShape2D.shape.extents = view_size/2
	$Area2D/CollisionShape2D.position = view_size/2
	
	$Area2D.connect("body_shape_exited", self, "_on_body_exit")
	
	
func _physics_process(delta):
	
	$Area2D/stars.position.x = camera.position.x * (-parallax_x_amount)
	
	while $Area2D/stars.get_child_count() < max_stars:
		add_star()
	
func add_star():
	
	var new_star = preload("res://stars/star.tscn").instance()
	new_star.position = Vector2( randi()%int(view_size.x), randi()%int(view_size.y) )
	new_star.position.x += (camera.position.x * parallax_x_amount)
	stars.add_child(new_star)

