extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	self.text = "FASE " + str(global_data.stage)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func next_stage(stage):
	self.text = "FASE " + str(stage)
