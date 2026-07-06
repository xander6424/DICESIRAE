extends Control

signal _update_round_status()

@onready var score_button: Button = %ScoreButton
@onready var lots_label: Label = %Lots
@onready var reroll_label: Label = %Rerolls
@onready var money_label: Label = %Money
@onready var grand_total_label: Label = %Total
@onready var total_to_beat_label: Label = %TotalToBeat
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


func _reset_scorecard() -> void:
	# Add only starting categories to the scorecard
	var scorecard_index: int = 0
	CategoryData.active_category_info_list.clear()
	
	for category in CategoryData.FULL_CATEGORY_LIST:
		if category.id in CategoryData.starting_category_list[0]:
			category_label_list[scorecard_index].text = category.category_name + ":"
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
	GameData.scoring_dice_list.clear()
	for dice in GameData.rolling_dice_list:
		GameData.scoring_dice_list.append(dice)
	for dice in GameData.saved_dice_list:
		GameData.scoring_dice_list.append(dice)
	
	for category in CategoryData.active_category_info_list:
		category.total = 0
		
		# Checks if a category exists in current hand
		if !category.scored:
			var valid: bool = category.check_validity()
			
			# Indicate if category exists in hand
			if valid:
				category.label.add_theme_color_override("font_color", Color.YELLOW)
			else:
				category.label.add_theme_color_override("font_color", Color.WHITE)
			
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
		
		if category_selected:
			var total_scored: int = 0
			
			if current_category.valid:
				total_scored = current_category.base_score + current_category.score_category()
				
				# TEMP PIECE DICE ACTIVATION (ADD ONLY)
				for piece in PieceData.active_piece_list:
					total_scored += piece.dice_scored()
				
				total_scored *= current_category.mult_score
				GameData.grand_total += total_scored
				
				current_category.label.add_theme_color_override("font_color", Color.WHITE)
				
			current_category.scored = true
			current_category.button.disabled = true
			current_category.button.text = str(total_scored)
			GameData.current_lot_scored = true
			
			_update_labels()
			_update_round_status.emit()
