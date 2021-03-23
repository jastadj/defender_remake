extends Node

var gameseed
var rotating_palette

func _init():
	gameseed = OS.get_unix_time()
	seed(gameseed)

func _ready():
	rotating_palette = preload("res://rotating_palette.gd").new()
	add_child(rotating_palette)
