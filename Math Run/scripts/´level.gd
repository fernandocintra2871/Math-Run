extends Node2D

var bar
var slots
var cards
var card_list
var resul_list
var slot_matriz
var crossword

func gen_exp(n_val, op):
	var exp = []
	exp.append(str(randi_range( 0, 9 )))
	for i in range(n_val-1):
		exp.append(str(op[randi_range(0, len(op)-1)]))
		exp.append(str(randi_range( 0, 9 )))
	var expression = Expression.new()
	var temp = str(exp).replace("[", "").replace("]", "").replace("\"", "").replace(", ", "")
	#print(temp)
	expression.parse(temp)
	var resul = expression.execute()
	#print(resul)
	exp.append("=")
	exp.append(str(resul))
	if resul == null:
		return gen_exp(n_val, op)
	return exp

func place(word, crossword, i, j, direction):
	for caracter in word:
		crossword[i][j] = caracter
		if direction == "h":
			j += 1
		elif direction == "v":
			i += 1
	return crossword

func canPlace(word, c, crossword, i, j):
	var place_i = i - c
	var place_j = j
	var placeable = true
	var place_dir = null
	for caracter in word:
		if place_i > len(crossword) - 2 or place_i < 1:
			placeable = false
			break
		if crossword[i-1][j] != " " or crossword[i+1][j] != " ":
			placeable = false
			break
		if crossword[i][j+1] == "=" or crossword[i][j-1] == "=":
			placeable = false
			break
		if place_i != i and crossword[place_i][place_j] != " " and crossword[place_i][place_j] != caracter:
			placeable = false
			break
		place_i += 1
		
	if placeable == true:
		return [placeable, i - c, j, "v"]
		
	place_i = i
	place_j = j - c
	placeable = true
	
	for caracter in word:
		if place_j > len(crossword) - 2 or place_j < 1:
			placeable = false
			break
		if crossword[i][j-1] != " " or crossword[i][j+1] != " ":
			placeable = false
			break
		if place_j != j and crossword[place_i][place_j] != " " and crossword[place_i][place_j] != caracter:
			placeable = false
			return [placeable, place_i, place_j, place_dir]
		place_j += 1
		
	return [placeable, i, j - c, "h"]

func display(crossword):
	for i in range(len(crossword)):
		for j in range(len(crossword)):
			printraw(crossword[i][j])
		print()

func create(prop):
	var crossword = []
	for i in range(prop):
		var row = []
		for j in range(prop):
			row.append(" ")
		crossword.append(row)
	return crossword

func fill2(crossword, num, ops):
	var word = gen_exp(3, ops)
	place(word, crossword, len(crossword)/2, len(crossword)/2 - len(word)/2, "h")
	var placed = false
	var count = 2
	while count <= num:
		word = gen_exp(3, ops)
		for c in range(len(word)):
			for i in range(len(crossword)):
				for j in range(len(crossword)):
					if word[c] == crossword[i][j] and word[c] not in ["+", "-", "*", "/", "="]:
						var placement = canPlace(word, c, crossword, i, j)
						if placement[0] == true:
							place(word, crossword, placement[1], placement[2], placement[3])
							placed = true
							count += 1
							break
				if placed == true:
					break
			if placed == true:
				break
		placed = false
	return crossword

func create_crossword(crossword):
	resul_list = []
	card_list = []
	var slot_scene = preload("res://slot.tscn")
	var equals_op_scene = preload("res://equals_operator.tscn")
	var ex_value_scene = preload("res://expected_value.tscn")
	var full_frame_scene = preload("res://full_frame.tscn")
	var cod_ex_values = []
	var des_x = (32/2 * 50) - (len(crossword)/2 * 50)
	var des_y = (18/2 * 50) - (len(crossword)/2 * 50)
	for i in range(len(crossword)):
		for j in range(len(crossword)):
			if crossword[i][j] == "=":
				var equals_op_instance = equals_op_scene.instantiate()
				equals_op_instance.position = Vector2(50*j + des_x, 50*i + des_y)
				add_child(equals_op_instance)
				if crossword[i][j+1] != " ":
					cod_ex_values.append([i, j+1])
				elif crossword[i+1][j] != " ":
					cod_ex_values.append([i+1, j])
			elif [i, j] in cod_ex_values:
				var ex_value_instance = ex_value_scene.instantiate()
				ex_value_instance.position = Vector2(50*j + des_x, 50*i + des_y)
				ex_value_instance.get_child(1).set_text(crossword[i][j])
				add_child(ex_value_instance)
				cod_ex_values.erase([i, j])
				resul_list.append(crossword[i][j])
			elif crossword[i][j] != " ":
				var slot_instance = slot_scene.instantiate()
				slot_instance.position = Vector2(50*j + des_x, 50*i + des_y)
				slot_instance.add_to_group("Slots")
				add_child(slot_instance)
				card_list.append(crossword[i][j])
				slot_matriz[i][j] = slot_instance
			else:
				var full_frame_instance = full_frame_scene.instantiate()
				full_frame_instance.position = Vector2(50*j + des_x, 50*i + des_y)
				add_child(full_frame_instance)
	return

func create_bar(num):
	var bar_scene = preload("res://bar.tscn")
	var i = 0
	var j = 0
	for n in range(num):
		var bar_instance = bar_scene.instantiate()
		bar_instance.add_to_group("Bar")
		bar_instance.position = Vector2(50*i + 550, 50*j + 750)
		add_child(bar_instance)
		if i > 8:
			j += 1
			i = 0
		else:
			i += 1
			
func create_cards(card_list):
	var card_scene = preload("res://card.tscn")
	for i in range(len(card_list)):
		var card_instance = card_scene.instantiate()
		card_instance.add_to_group("Cards")
		card_instance.current_slot = bar[i]
		card_instance.position = bar[i].position
		card_instance.data = card_list[i]
		bar[i].card = card_instance
		bar[i].empty = false
		add_child(card_instance)
	
func validation():
	var n = len(crossword)
	for i in range(n):
		for j in range(n):
			if crossword[i][j] == "=":
				var exp = ""
				var r = ""
				if crossword[i][j+1] != " " and crossword[i][j+2] == " ":
					r = crossword[i][j+1]
					for c in range(5, 0, -1):
						if slot_matriz[i][j-c] != null:
							if !slot_matriz[i][j-c].empty:
								exp += slot_matriz[i][j-c].card.data
								#print(exp)
							else:
								return false
						else:
							if crossword[i-1][j-c] == "=":
								exp += crossword[i][j-c]
							else:
								return false
				elif crossword[i+1][j] != " " and crossword[i+2][j] == " ":
					r = crossword[i+1][j]
					for c in range(5, 0, -1):
						#print(slot_matriz[i-c][j])
						if slot_matriz[i-c][j] != null:
							if !slot_matriz[i-c][j].empty:
								exp += slot_matriz[i-c][j].card.data
								#print(exp)
							else:
								return false
						else:
							if crossword[i-c][j-1] == "=":
								exp += crossword[i-c][j]
							else:
								return false
				var expression = Expression.new()
				expression.parse(exp)
				var resul = str(expression.execute())
				print(exp)
				print(resul)
				if resul != r:
					return false
	print("ok")
	return true
	
func check():
	#print(card_list)
	#print(resul_list)
	#print(slots)
	
	var finish = validation()
	if finish:
		var timer = get_node("/root/Main/interface/Timer")
		timer.stop()
		timer.win_dialog()
		
# Função para debugar	
func pular():
	var timer = get_node("/root/Main/interface/Timer")
	timer.stop()
	timer.win_dialog()
	
func _ready():
	print("start...")
	
	$gameMusic.play()
	$gameMusic.volume_db = global_data.music_vol
	
	var background_texture = TextureRect.new()
	var texture = preload("res://assets/background.png")
	background_texture.texture = texture
	add_child(background_texture)
	
	var interface_scene = preload("res://interface.tscn")
	var interface_instance = interface_scene.instantiate()
	add_child(interface_instance)
	
	crossword = create(10)
	slot_matriz = create(10)
	
	var num_exp
	var operators
	
	if global_data.stage == 1:
		num_exp = 1
		operators = ["+"]
	elif global_data.stage == 2:
		num_exp = 2
		operators = ["+"]
	elif global_data.stage == 3:
		num_exp = 2
		operators = ["+", "-"]
	elif global_data.stage <= 4:
		num_exp = 3
		operators = ["+", "-"]
	elif global_data.stage <= 5:
		num_exp = 4
		operators = ["+", "-"]
	elif global_data.stage == 6:
		num_exp = 4
		operators = ["+", "-", "*"]
	elif global_data.stage == 7:
		num_exp = 5
		operators = ["+", "-", "*"]
	elif global_data.stage == 8:
		num_exp = 5
		operators = ["+", "-", "*"]
	elif global_data.stage >= 9:
		num_exp = 5
		operators = ["+", "-", "*", "/"]
		
	crossword = fill2(crossword, num_exp, operators)
	display(crossword)
	
	create_crossword(crossword)
	slots = get_tree().get_nodes_in_group("Slots")
	
	print(card_list)
	shuffle_list(card_list)
	print(card_list)
	
	create_bar(len(card_list))
	bar = get_tree().get_nodes_in_group("Bar")
	create_cards(card_list)
	cards = get_tree().get_nodes_in_group("Cards")

	print("finish")
		
func shuffle_list(list_to_shuffle):
	var n = list_to_shuffle.size()

	for i in range(n - 1, 0, -1):
		var j = randi() % (i + 1)
		
		# Trocar os elementos usando uma variável auxiliar
		var temp = list_to_shuffle[i]
		list_to_shuffle[i] = list_to_shuffle[j]
		list_to_shuffle[j] = temp	
			
func _process(delta):
	if Input.is_action_just_pressed("p"):
		pular()
		print("p")
