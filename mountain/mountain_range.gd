extends Line2D

var segments = 10
var amplitude = 50


func create_range(range_width, noise_x_pos):
	var noise = OpenSimplexNoise.new()
	var rangepoints = []
	var seglen = range_width / segments
	
	for p in range(0, segments+1):
		var noise_x = noise_x_pos + seglen*p
		var noise_y = noise.get_noise_1d(noise_x)
		rangepoints.push_back( Vector2(p*seglen, noise_y*amplitude) )
	
	points = rangepoints

	
