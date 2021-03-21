extends Sprite

var max_lifetime = 5000
var min_lifetime = 3000
var lifetime = 0
var birth_time
var kill_me = 0

var colors = [Color(1,0,0), Color(0,1,0), Color(0,0,1), Color(1,0,1), Color(1,1,0) ]

func _ready():
	self_modulate = colors[randi()%colors.size()]
	self_modulate.a = 0.5
	birth_time = OS.get_ticks_msec()
	lifetime = randi()%(max_lifetime - min_lifetime) + min_lifetime
	
func _physics_process(delta):
	if kill_me: return
	if birth_time + lifetime <= OS.get_ticks_msec():
		kill_me = 1
		queue_free()
