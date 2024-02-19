extends TextureButton

func _on_pressed():
	get_node("/root/menu/VBox1/HBox1/VBox2/clickAudio").play()
	get_tree().change_scene_to_file("res://level.tscn")


func _on_mouse_entered():
	self.scale = Vector2(1.1, 1.1)
	get_node("/root/menu/VBox1/HBox1/VBox2/selectAudio").play()


func _on_mouse_exited():
	self.scale = Vector2(1, 1)
