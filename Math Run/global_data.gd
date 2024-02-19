extends Node

var stage = 0
var scores = []
var last_win
var music_vol = -20
var fullscreen = false

func _ready():
	global_data.scores = load_save()
	
func load_save():
	var file = FileAccess.open("user://save_game.dat", FileAccess.READ)
	var content = file.get_var()
	return content
