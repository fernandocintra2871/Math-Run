extends TextureButton

func _on_pressed():
	var end_time = get_node("/root/Main/interface/Timer").time
	global_data.last_win = {"stage":global_data.stage, "end_time":end_time}
	global_data.stage += 1
	get_tree().reload_current_scene()


func _on_mouse_entered():
	self.scale = Vector2(1.1, 1.1)


func _on_mouse_exited():
	self.scale = Vector2(1, 1)
