extends TextureButton

func _on_pressed():
	get_node("/root/about/clickAudio").play()
	get_tree().change_scene_to_file("res://menu.tscn")


func _on_mouse_entered():
	self.scale = Vector2(1.1, 1.1)
	get_node("/root/about/selectAudio").play()


func _on_mouse_exited():
	self.scale = Vector2(1, 1)
