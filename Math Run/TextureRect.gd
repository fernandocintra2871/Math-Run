extends TextureRect

const node: PackedScene = preload("res://player.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_mouse_entered():
	$HBoxContainer2.add_child(self)
	$HBoxContainer.remove_child(self)
