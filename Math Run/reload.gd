extends TextureButton

func _on_pressed():
	if global_data.stage > 1:
		var date = Time.get_date_dict_from_system()
		var time = Time.get_time_dict_from_system()
		var text = "Fase %02d com %02ds - Dia %02d/%02d/%s às %02d:%02d:%02d" % [global_data.last_win["stage"], global_data.last_win["end_time"], date["day"], date["month"], date["year"], time["hour"], time["minute"], time["second"]]
		global_data.scores.append(text)
	global_data.stage = 1
	global_data.last_win = {}
	get_tree().reload_current_scene()


func _on_mouse_entered():
	self.scale = Vector2(1.1, 1.1)


func _on_mouse_exited():
	self.scale = Vector2(1, 1)
