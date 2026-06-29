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

# removed category class from here

# Initialize category name, base score, mult score, and id
var aces: CategoryInfo = CategoryInfo.new("Aces", 5, 1, DiceData.Category.ACES)
var twos: CategoryInfo = CategoryInfo.new("Twos", 5, 1, DiceData.Category.TWOS)
var threes: CategoryInfo = CategoryInfo.new("Threes", 10, 1, DiceData.Category.THREES)
var fours: CategoryInfo = CategoryInfo.new("Fours", 10, 1, DiceData.Category.FOURS)
var choice: CategoryInfo = CategoryInfo.new("Choice", 0, 1, DiceData.Category.CHOICE)
var two_pair: CategoryInfo = CategoryInfo.new("Two Pair", 15, 2, DiceData.Category.TWO_PAIR)
var three_of_a_kind: CategoryInfo = CategoryInfo.new("Three of a Kind", 20, 3, DiceData.Category.THREE_OF_A_KIND)

var category_info_list: Array[CategoryInfo] = [aces, twos, threes, fours, choice, two_pair, three_of_a_kind]
var active_category_info_list: Array[CategoryInfo] = []

func _ready() -> void:
	score_button.pressed.connect(_score_button_pressed)
	
	_update_labels()
	_reset_scorecard()

func _update_labels() -> void:
	lots_label.text = "Lots: " + str(GameData.lots)
	reroll_label.text = "Rerolls: " + str(GameData.rerolls)
	money_label.text = "Money: $" + str(GameData.money)
	grand_total_label.text = "TOTAL: " + str(GameData.grand_total)
	total_to_beat_label.text = "Score to Beat: " + str(GameData.score_to_beat) # Change?


func _reset_scorecard() -> void:
	# Add only starting categories to the scorecard
	var scorecard_index: int = 0
	
	for category in category_info_list:
		if category.id in DiceData.starting_category_list[0]:
			category_label_list[scorecard_index].text = category.category_name + ":"
			category_button_list[scorecard_index].text = str(category.base_score) + " + 0 x " + str(category.mult_score)
			#category_button_list[scorecard_index].pressed.connect(category_button_pressed)
			
			category.label = category_label_list[scorecard_index]
			category.button = category_button_list[scorecard_index]
			category.button.disabled = false
			category.button.button_pressed = false
			category.scored = false
			
			active_category_info_list.append(category)
			scorecard_index += 1

func _update_scorecard() -> void:
	var scorecard_dice_list: Array[int] = []
	
	for dice in GameData.rolling_dice_list:
		scorecard_dice_list.append(dice)
	for dice in GameData.saved_dice_list:
		scorecard_dice_list.append(dice)
	
	for category in active_category_info_list:
		category.total = 0
		
		if !category.scored:
			match category.id:
				DiceData.Category.ACES:
					for dice in scorecard_dice_list:
						if dice == 1:
							category.total += dice
				DiceData.Category.TWOS:
					for dice in scorecard_dice_list:
						if dice == 2:
							category.total += dice
				DiceData.Category.THREES:
					for dice in scorecard_dice_list:
						if dice == 3:
							category.total += dice
				DiceData.Category.FOURS:
					for dice in scorecard_dice_list:
						if dice == 4:
							category.total += dice
				DiceData.Category.CHOICE:
					for dice in scorecard_dice_list:
						category.total += dice
				DiceData.Category.TWO_PAIR:
					var pairs: int = 0
					var banned_face: int = -1
					var four_of_a_kind: bool = false
					
					for dice in scorecard_dice_list:
						# Check for possible four of a kind
						if scorecard_dice_list.count(dice) >= 4:
							four_of_a_kind = true
							category.total += dice * 4
							break
						# Check for a pair
						elif scorecard_dice_list.count(dice) >= 2 and dice != banned_face:
							category.total += dice * 2
							banned_face = dice
							pairs += 1
							
							# Exit if a two pair is found
							if pairs == 2:
								break
						
					# Reset score if no two pair is found
					if pairs < 2 and !four_of_a_kind:
						category.total = 0
				DiceData.Category.THREE_OF_A_KIND:
					for dice in scorecard_dice_list:
						if scorecard_dice_list.count(dice) >= 3:
							category.total += dice * 3
							break
			
			category.button.text = str(category.base_score) + " + " + str(category.total) + " x " + str(category.mult_score)


func _score_button_pressed() -> void:
	# Category won't score until dice have been rolled once
	if !GameData.first_round_roll:
		var current_category: CategoryInfo
		var category_selected: bool = false
		
		# Find which category was selected
		for category in active_category_info_list:
			if category.button.button_pressed:
				current_category = category
				category_selected = true
				break
		
		if category_selected:
			var scored_total: int = 0
			if current_category.total > 0:
				scored_total = (current_category.base_score + current_category.total) * current_category.mult_score
				GameData.grand_total += scored_total
				
			current_category.scored = true
			current_category.button.disabled = true
			current_category.button.text = str(scored_total)
			GameData.current_lot_scored = true
			
			_update_labels()
			_update_round_status.emit()
			
		else:
			print("Please select a category")
