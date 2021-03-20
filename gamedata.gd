extends Node

var gameseed

func _init():
	gameseed = OS.get_unix_time()
	seed(gameseed)
