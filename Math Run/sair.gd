extends TextureButton

func _on_pressed():
	get_node("/root/menu/VBox1/HBox1/VBox2/clickAudio").play()
	save(global_data.scores)
	get_tree().quit()


func _on_mouse_entered():
	self.scale = Vector2(1.1, 1.1)
	get_node("/root/menu/VBox1/HBox1/VBox2/selectAudio").play()

func _on_mouse_exited():
	self.scale = Vector2(1, 1)
	
func save(content):
	var file = FileAccess.open("user://save_game.dat", FileAccess.WRITE)
	file.store_var(content)
