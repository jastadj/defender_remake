extends Control

export(Color) var line_color

func _ready():
	set_line_color(line_color)

func set_line_color(color):
	line_color = color
	$Status_Bar/Status_Bar_Lines.modulate = line_color
