extends Node

var gameseed
var rotating_palette
var tracer_noise

func _init():
	gameseed = OS.get_unix_time()
	seed(gameseed)
	

func _ready():
	
	rotating_palette = preload("res://rotating_palette.gd").new()
	add_child(rotating_palette)
	
	# generate tracer noise texture
	var noiseimage = Image.new()
	noiseimage.create(get_viewport().size.x,2,false,Image.FORMAT_RGBA8)
	noiseimage.fill(Color(0,0,0,0))
	noiseimage.lock()
	for i in range(0, get_viewport().size.x):
		if randi()%4:
			noiseimage.set_pixel(i, 0, Color(1,1,1,1))
			noiseimage.set_pixel(i, 1, Color(1,1,1,1))
	noiseimage.unlock()
	tracer_noise = ImageTexture.new()
	tracer_noise.create_from_image(noiseimage)

	
