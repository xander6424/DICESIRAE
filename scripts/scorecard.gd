extends Control

signal _on_update_round_status()

@onready var score_button: Button = %ScoreButton

@onready var lots_label: Label = %Lots
@onready var reroll_label: Label = %Rerolls
@onready var money_label: Label = %Money
@onready var grand_total_label: Label = %Total
@onready var total_to_beat_label: Label = %TotalToBeat

@onready var draw_pile_label: Label = %DrawPile
@onready var discard_pile_label: Label = %DiscardPile

@onready var piece_count_label: Label = %PieceCount

@onready var category_label_list = [%CategoryLabel1, %CategoryLabel2, %CategoryLabel3, %CategoryLabel4, %CategoryLabel5]
@onready var category_button_list = [%CategoryButton1, %CategoryButton2, %CategoryButton3, %CategoryButton4, %CategoryButton5]


func _ready() -> void:
	score_button.pressed.connect(_score_button_pressed)
	_update_labels()

func _update_labels() -> void:
	lots_label.text = "Lots: " + str(GameData.lots)
	reroll_label.text = "Rerolls: " + str(GameData.rerolls)
	money_label.text = "Money: $" + str(GameData.money)
	grand_total_label.text = "TOTAL: " + str(GameData.grand_total)
	total_to_beat_label.text = "Score to Beat: " + str(GameData.score_to_beat) # Change?
	
	draw_pile_label.text = str(DiceManager.draw_pile.size()) + "/" + str(DiceManager.MAX_DRAW_PILE_SIZE)
	discard_pile_label.text = str(DiceManager.discard_pile.size()) + "/" + str(DiceManager.MAX_DRAW_PILE_SIZE)
	
	piece_count_label.text = str(PieceManager.active_piece_list.size()) + "/" + str(PieceManager.MAX_PIECES_SIZE)
	
	# Test output
	#print("ROLLING LIST: ", DiceManager.rolling_dice_list)
	#print("SAVED LIST: ", DiceManager.saved_dice_list)
	#print("DISCARD PILE: ", DiceManager.discard_pile)
	

func _reset_scorecard() -> void:
	# Add only starting categories to the scorecard
	var scorecard_index: int = 0
	CategoryData.active_category_info_list.clear()
	
	for category in CategoryData.FULL_CATEGORY_LIST:
		if category.id in CategoryData.starting_category_list[0]:
			category_label_list[scorecard_index].text = "LVL. " + str(category.level) + " | " + category.category_name + ":"
			category_button_list[scorecard_index].text = str(category.base_score) + " + 0 x " + str(category.mult_score)
			#category_button_list[scorecard_index].pressed.connect(category_button_pressed)
			
			category.label = category_label_list[scorecard_index]
			category.button = category_button_list[scorecard_index]
			category.button.disabled = false
			category.button.button_pressed = false
			category.scored = false
			
			CategoryData.active_category_info_list.append(category)
			scorecard_index += 1

func _update_scorecard() -> void:
	# If a new category is purchased, then reset scorecard too
	check_category_existance()

func check_category_existance() -> void:
	for category in CategoryData.active_category_info_list:
		category.total = 0 # Possibly remove this eventually?
		
		# Checks if an unscored category exists in current hand
		if !category.scored:
			category.check_hand_existance(DiceManager.all_dice_list)
			category.check_saved_existance(DiceManager.saved_dice_list)
			
			# Indicate if category exists by color
			if category.exists_in_saved:
				category.label.add_theme_color_override("font_color", Color.GOLD)
			elif category.exists_in_hand:
				category.label.add_theme_color_override("font_color", Color.YELLOW)
			else:
				category.label.add_theme_color_override("font_color", Color.WHITE)
			
			category.label.text = "LVL. " + str(category.level) + " | " + category.category_name + ":"
			category.button.text = str(category.base_score) + " + " + str(category.total) + " x " + str(category.mult_score)


func _score_button_pressed() -> void:
	# Category won't score until dice have been rolled once
	if !GameData.first_round_roll:
		var current_category: CategoryInfo
		var category_selected: bool = false
		
		# Find which category was selected
		for category in CategoryData.active_category_info_list:
			if category.button.button_pressed:
				current_category = category
				category_selected = true
				break
		
		if category_selected and !current_category.scored:
			var category_total: int = 0
			
			GameData.total_add_score = 0
			GameData.total_mult_score = current_category.mult_score
			DiceManager.scoring_dice_list.clear()
			
			# Only checks to score if category is even valid
			if current_category.exists_in_saved:
				DiceManager.scoring_dice_list = current_category.valid_dice_list.duplicate()
				category_total = score_category(category_total, current_category)
			
			current_category.label.add_theme_color_override("font_color", Color.WHITE)
			
			current_category.scored = true
			current_category.button.disabled = true
			current_category.button.text = str(category_total)
			GameData.current_lot_scored = true
			
			_update_labels()
			_on_update_round_status.emit()

func score_category(category_total: int, category: CategoryInfo):
	# Score saved dice only
	var dice_to_score = DiceManager.scoring_dice_list.duplicate()
	
	for dice in dice_to_score:
		print("+", str(dice.score_dice()))
		GameData.total_add_score += dice.score_dice()
		dice.scored = true
		
		PieceManager.dice_scored(dice)
	
	# Score pieces
	print("\nSCORING PIECES")
	PieceManager.pieces_scored()
	
	# Full scoring
	GameData.total_add_score += category.base_score
	GameData.total_add_score *= GameData.total_mult_score
	category_total = GameData.total_add_score
	GameData.grand_total += category_total
	
	PieceManager.reset_piece_values()
	
	return category_total
