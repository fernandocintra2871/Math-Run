extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	global_data.stage = 1
	$menuMusic.play()
	$menuMusic.volume_db = global_data.music_vol

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func load_save():
	var file = FileAccess.open("user://save_game.dat", FileAccess.READ)
	var content = file.get_var()
	return content
