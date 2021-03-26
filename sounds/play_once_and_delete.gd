extends AudioStreamPlayer

func _ready():
	
	connect("finished", self, "_on_finished_playing")
	
func _on_finished_playing():
	queue_free()
