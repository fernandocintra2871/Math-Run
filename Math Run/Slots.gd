extends StaticBody2D

var empty = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_empty():
	return empty
	
func set_empty():
	empty = !empty
