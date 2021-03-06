extends Node2D

var MTN_RANGE_CHUNK_WIDTH = 1000

func _ready():
	
	$UI_LAYER/UI.set_line_color(Color(0,0.5,0))
	
func _physics_process(delta):
	
	# delete/add mountain range chunks as needed
	update_mountains()

func update_mountains():
	
	var expected_chunks = []
	expected_chunks.push_back( floor($player/Camera2D.to_global($player/Camera2D.position).x / MTN_RANGE_CHUNK_WIDTH) )
	expected_chunks.push_back( expected_chunks[0]-1 )
	expected_chunks.push_back( expected_chunks[0]+1 )
	
	for m in $mountains.get_children():
		var mchunk = m.position.x / MTN_RANGE_CHUNK_WIDTH
		if !(mchunk in expected_chunks):
			m.queue_free()
		else:
			expected_chunks.erase(mchunk)
	
	for mtn_chunk in expected_chunks:
		add_mountain(mtn_chunk)

func add_mountain(x_chunk):
	
	var new_range = preload("res://mountain/mountain_range.tscn").instance()
	
	new_range.position = Vector2(x_chunk*MTN_RANGE_CHUNK_WIDTH, get_viewport_rect().size.y - 80)
	new_range.create_range(MTN_RANGE_CHUNK_WIDTH, x_chunk*MTN_RANGE_CHUNK_WIDTH)
	$mountains.add_child(new_range)

