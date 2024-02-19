extends Timer

var time
var timer
var stopwatch

func _ready():
	time = 0
	timer = get_node("/root/Main/interface/stopwatch")
	self.start()

func _process(delta):
	if Input.is_action_just_pressed("l"):
		perder()
		print("l")

func _on_timeout():
	time += 1
	
	var minutes = time / 60
	var seconds = time % 60
	
	var minutes_str = str(minutes) if minutes >= 10 else "0" + str(minutes)
	var seconds_str = str(seconds) if seconds >= 10 else "0" + str(seconds)
	
	var stopwatch = minutes_str + ":" + seconds_str
	
	timer.text = stopwatch
	
	if minutes >= 3:
		self.stop()
		defeat_dialog()
	
func win_dialog():
	var win_scene = preload("res://win_dialog.tscn")
	var win_instance = win_scene.instantiate()
	add_child(win_instance)
	$winAudio.play()
	
func defeat_dialog():
	var defeat_scene = preload("res://defeat_dialog.tscn")
	var defeat_instance = defeat_scene.instantiate()
	add_child(defeat_instance)
	$defeatAudio.play()
	
func perder():
	defeat_dialog()
	stopwatch = "03:00"
	self.stop()
	timer.text = stopwatch
