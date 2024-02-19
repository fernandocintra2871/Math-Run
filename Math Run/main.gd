extends Node

var slots

# Called when the node enters the scene tree for the first time.
func _ready():
	slots = get_tree().get_nodes_in_group("Slots")
	print(slots)
	
	var bar = get_tree().get_nodes_in_group("Bar")
	print(bar)
	
	var cards = get_tree().get_nodes_in_group("Cards")
	print(cards)
	
	for i in range(4):
		print(bar[i])
		print(cards[i])
		cards[i].current_slot = bar[i]
		cards[i].position = bar[i].position
		bar[i].card = cards[i]
		
	cards[0].data = "1"
	cards[1].data = "2"
	cards[2].data = "5"
	cards[3].data = "+"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass
	
func check():
	for i in range(len(slots)):
		if slots[i].empty:
			return false
	return expression_gen()
	
func expression_gen():
	var txt = ""
	for i in range(len(slots)):
		var card = slots[i].card.data
		txt += card
	var expression = Expression.new()
	expression.parse(txt)
	var result = expression.execute()
	return result
