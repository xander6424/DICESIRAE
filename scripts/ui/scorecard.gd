extends Control

signal _on_update_round_status()

@onready var roll_button: TextureButton = %RollButton
@onready var score_button: TextureButton = %ScoreButton
const SCOREBUTTON_NORMAL = preload("uid://cbu740jokytb4")
const SCOREBUTTON_HOVER = preload("uid://bdommmoswq7f1")
const SCOREBUTTON_READY = preload("uid://dd5x7v6oocnth")
const SCOREBUTTON_READY_HOVER = preload("uid://cia4rmehekym7")

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
@onready var category_button_label_list = [%CategoryButtonLabel1, %CategoryButtonLabel2, %CategoryButtonLabel3, %CategoryButtonLabel4, %CategoryButtonLabel5]

func _ready() -> void:
	PieceManager._update_scorecard.connect(_update_scorecard)
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
	print("RESET SCORECARD\n")
	
	# Add only starting categories to the scorecard
	var scorecard_index: int = 0
	CategoryData.active_category_info_list.clear()
	
	for category in CategoryData.FULL_CATEGORY_LIST:
		if category.id in CategoryData.starting_category_list[0]:
			category.total = 0
			category.add_score = category.base_add_score
			category.mult_score = category.base_mult_score
			
			category_label_list[scorecard_index].text = "LVL. " + str(category.level) + " | " + category.category_name + ":"
			category_button_label_list[scorecard_index].text = str(category.add_score) + "[color=aqua] + 0[/color][color=red] x " + str(category.mult_score) + "[/color]"
			#category_button_list[scorecard_index].pressed.connect(category_button_pressed)
			
			category.label = category_label_list[scorecard_index]
			category.button = category_button_list[scorecard_index]
			category.button_label = category_button_label_list[scorecard_index]
			category.button.disabled = false
			category.button.button_pressed = false
			category.scored = false
			
			CategoryData.active_category_info_list.append(category)
			scorecard_index += 1

func _update_scorecard() -> void:
	# If a new category is purchased, then reset scorecard too
	check_category_existance()

func check_category_existance() -> void:
	var category_exists: bool = false
	
	for category in CategoryData.active_category_info_list:
		# Checks if an unscored category exists in current hand
		if !category.scored:
			category.check_hand_existance(DiceManager.all_dice_list)
			category.check_saved_existance(DiceManager.saved_dice_list)
			
			# Indicate if category exists by color
			if category.exists_in_saved:
				category.label.add_theme_color_override("font_color", Color.GOLD)
				
				category_exists = true
				score_button.texture_normal = SCOREBUTTON_READY
				score_button.texture_hover = SCOREBUTTON_READY_HOVER
			elif category.exists_in_hand:
				category.label.add_theme_color_override("font_color", Color.YELLOW)
			else:
				category.label.add_theme_color_override("font_color", Color.WHITE)
			
			category.label.text = "LVL. " + str(category.level) + " | " + category.category_name + ":"
			category.button_label.text = str(category.add_score) + "[color=aqua] + " + str(category.total) + "[/color][color=red] x " + str(category.mult_score) + "[/color]"
	
	if !category_exists:
		score_button.texture_normal = SCOREBUTTON_NORMAL
		score_button.texture_hover = SCOREBUTTON_HOVER

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
			score_button.disabled = true
			roll_button.disabled = true
			
			var category_total: int = 0
			
			current_category.total = 0
			DiceManager.scoring_dice_list.clear()
			
			# Only checks to score if category is even valid
			if current_category.exists_in_saved:
				DiceManager.scoring_dice_list = current_category.valid_dice_list.duplicate()
				category_total = await score_category(category_total, current_category)
			
			current_category.label.add_theme_color_override("font_color", Color.WHITE)
			
			score_button.disabled = false
			roll_button.disabled = false
			current_category.scored = true
			current_category.button.disabled = true
			current_category.button_label.text = str(category_total)
			GameData.current_lot_scored = true
			
			_update_labels()
			_on_update_round_status.emit()

func score_category(category_total: int, category: CategoryInfo):
	# Score saved dice only
	var dice_to_score = DiceManager.scoring_dice_list.duplicate()
	
	for dice in dice_to_score:
		print("+", str(dice.score_dice()))
		
		var dice_value: int = dice.score_dice()
		dice.scored = true
		
		var dice_display: DiceDisplay = DiceManager.get_display(dice)
		if dice_display:
			# Update scorecard visual values
			category.add_score += dice_value
			_update_scorecard()
			
			await dice_display.show_score(dice_value, Color.WHITE).finished
		
		await get_tree().create_timer(0.35).timeout
		
		await PieceManager.dice_scored(dice, category)
	
	# Score pieces
	print("\nSCORING PIECES")
	
	for display in PieceManager.active_display_list:
		await PieceManager.pieces_scored(display, category)
	
	# Full scoring
	category.total += category.add_score
	category.total *= category.mult_score
	category_total = category.total
	GameData.grand_total += category_total
	
	PieceManager.reset_piece_values()
	
	
	return category_total
