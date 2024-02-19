extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	%music_vol_slider.value = global_data.music_vol
	if global_data.fullscreen:
		%tela_cheia_checkbox.button_pressed = true
	else:
		%tela_cheia_checkbox.button_pressed = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_tela_cheia_checkbox_toggled(button_pressed):
	if button_pressed:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		global_data.fullscreen = true
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		global_data.fullscreen = false

func _on_music_vol_slider_value_changed(value):
	global_data.music_vol = value
