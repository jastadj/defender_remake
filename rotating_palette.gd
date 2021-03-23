extends Node

var SPEED = 0.05

var color
var _colors = []
var _arclen
var rotator = Node2D.new()

func _init():
	_colors.push_back(Color(1,0,0))
	_colors.push_back(Color(0,1,0))
	_colors.push_back(Color(0,0,01))
	_colors.push_back(Color(1,1,1))
	
	color = _colors[0]
	
	_arclen = (2*PI) / _colors.size()
	
func _physics_process(delta):
	
	var time = delta*SPEED*OS.get_ticks_msec()
	var index = int(time)%_colors.size()
	var weight = time - floor(time)
	
	var index2 = index + 1
	if index2 >= _colors.size(): index2 = 0
	
	color = lerp(_colors[index], _colors[index2], weight)
	
