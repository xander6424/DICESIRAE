extends Control

#signal _buy_piece()
signal _on_update_round_status()
signal _on_piece_purchased(piece)

@onready var piece_button: Button = %PieceButton
@onready var upgrade_category_button: Button = %UpgradeCategoryButton
@onready var skip_button: Button = %SkipButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	piece_button.pressed.connect(piece_button_pressed)
	upgrade_category_button.pressed.connect(upgrade_button_pressed)
	skip_button.pressed.connect(_shop_skip_button_pressed)

# Random piece button
func piece_button_pressed() -> void:
	if GameData.money >= 3 and PieceManager.active_piece_list.size() < PieceData.max_piece_hand_size:
		# Prevent infinite loop (for now)
		if PieceManager.active_piece_list.size() != PieceData.FULL_PIECE_LIST.size():
			# Pick a random piece not in use
			var random_piece: PieceInfo = PieceData.FULL_PIECE_LIST.pick_random()
			
			while random_piece.using:
				random_piece = PieceData.FULL_PIECE_LIST.pick_random()
			
			PieceManager.active_piece_list.append(random_piece)
			random_piece.using = true
			_on_piece_purchased.emit(random_piece)
			print("PURCHASED: ", random_piece.piece_name)
			
			GameData.money -= 3
			
			_on_update_round_status.emit()
		else:
			print("MAXIMUM PIECES MET")
	else:
		print("UNABLE TO PURCHASE PIECE")


# Upgrade category button
func upgrade_button_pressed() -> void:
	if GameData.money >= 4:
		var category_selected: bool = false
		var current_category: CategoryInfo
		
		# Find which category was selected
		for category in CategoryData.active_category_info_list:
			if category.button.button_pressed:
				current_category = category
				category_selected = true
				break
		
		# Upgrade chosen category level
		if category_selected:
			match current_category.id:
				CategoryData.Category.ACES:
					current_category.base_score += 10
					current_category.mult_score += 1
				CategoryData.Category.TWOS:
					current_category.base_score += 10
					current_category.mult_score += 1
				CategoryData.Category.THREES:
					current_category.base_score += 10
					current_category.mult_score += 1
				CategoryData.Category.TWO_PAIR:
					current_category.base_score += 15
					current_category.mult_score += 1
				CategoryData.Category.THREE_OF_A_KIND:
					current_category.base_score += 15
					current_category.mult_score += 2
			
			current_category.level += 1
			GameData.money -= 4
			
			_on_update_round_status.emit()

# Modify dice button


func _shop_skip_button_pressed() -> void:
	GameData._reset_round.emit()
