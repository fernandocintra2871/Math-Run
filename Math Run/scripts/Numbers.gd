extends Area2D

var data = ""

var selected = false
var mouse_offset = Vector2(0, 0)

var current_slot
var next_slot
var return_position

func _ready():
	return_position = position

func _process(delta):
	$Label.set_text(data)
	if selected:
		followMouse()

func followMouse():
	position = get_global_mouse_position() + mouse_offset

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		self.z_index = 2
		if event.pressed:
			mouse_offset = position - get_global_mouse_position()
			selected = true
		else:
			if next_slot != null:
				if next_slot.empty:
					next_slot.empty = false
					current_slot.empty = true
					current_slot = next_slot
					current_slot.card = self
					return_position = current_slot.position
					$audio.play()
					next_slot = null
				else:
					var temp = current_slot
					print(temp.card.data)
					print(next_slot.card.data)
					next_slot.card.current_slot = temp
					next_slot.card.position = temp.position
					temp.card = next_slot.card
					next_slot.card = self
					current_slot = next_slot
					next_slot = null
				print(get_tree().get_root().get_node("Main").check())
			position = current_slot.position
			selected = false
			self.z_index = 0
			
