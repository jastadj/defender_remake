extends Line2D

var segments = 40
var amplitude = 50


func create_range(range_width, noise_x_pos):
	var noise = OpenSimplexNoise.new()
	
	var alt_range = ( randi()%100 > 75)
	var alt_segs = ( randi()%100 > 75)
	
	if alt_segs: segments = 20
	
	noise.seed = Gamedata.gameseed
	#noise.octaves = 4
	#noise.period = 20.0
	#noise.persistence = 0.8

	var rangepoints = []
	var seglen = range_width / segments
	
	for p in range(0, segments+1):
		var noise_x = (noise_x_pos + seglen*p)
		var noise_y = noise.get_noise_1d(noise_x)
		
		if alt_range and p > 0 and p < segments:
			rangepoints.push_back( Vector2(p*seglen, -50 + noise_y*amplitude*2) )
		else:
			rangepoints.push_back( Vector2(p*seglen, noise_y*amplitude) )
	
	points = rangepoints

	
