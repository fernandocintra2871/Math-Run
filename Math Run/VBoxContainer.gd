extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	print(global_data.scores)
	print(len(global_data.scores))
	if len(global_data.scores) > 0:
		var i = len(global_data.scores) - 1
		while (i > len(global_data.scores) - 11) && (i >= 0):
			add_score(global_data.scores[i])
			i = i - 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func add_score(text):
	var score_bar_scene = preload("res://score_bar.tscn")
	var score_bar_instance = score_bar_scene.instantiate()
	score_bar_instance.get_node("Label").text = text
	add_child(score_bar_instance)
	print("Pontuação Adicionada!")
	
func get_time():
	var date = Time.get_date_dict_from_system()
	print(date)
	var time = Time.get_time_dict_from_system()
	print(time) # {day:X, dst:False, hour:xx, minute:xx, month:xx, second:xx, weekday:x, year:xxxx}
