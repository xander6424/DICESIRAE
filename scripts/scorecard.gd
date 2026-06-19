extends Control

signal update_labels()
signal update_game_status(current_roll_scored: bool)

@onready var score_button: Button = %ScoreButton
@onready var category_label_list = [%CategoryLabel1, %CategoryLabel2, %CategoryLabel3, %CategoryLabel4, %CategoryLabel5]
@onready var category_button_list = [%CategoryButton1, %CategoryButton2, %CategoryButton3, %CategoryButton4, %CategoryButton5]

enum Categories {ACES, TWOS, THREES, FOURS, TWO_PAIR, THREE_OF_A_KIND}
var starting_category_list = [Categories.ACES, Categories.TWOS, Categories.THREES, Categories.TWO_PAIR, Categories.THREE_OF_A_KIND]

class CategoryInfo:
	var name: String
	var base_score: int
	var total: int = 0
	var id: Categories
	var scored: bool = false
	
	var label: Label = null
	var button: Button = null
	
	func _init(name: String, base_score: int, id: Categories):
		self.name = name
		self.base_score = base_score
		self.id = id

# Initialize category name, base score, and id
var aces = CategoryInfo.new("Aces", 5, Categories.ACES)
var twos = CategoryInfo.new("Twos", 5, Categories.TWOS)
var threes = CategoryInfo.new("Threes", 10, Categories.THREES)
var fours = CategoryInfo.new("Fours", 10, Categories.FOURS)
var two_pair = CategoryInfo.new("Two Pair", 20, Categories.TWO_PAIR)
var three_of_a_kind = CategoryInfo.new("Three of a Kind", 30, Categories.THREE_OF_A_KIND)
var category_info_list = [aces, twos, threes, fours, two_pair, three_of_a_kind]
var active_category_info_list = []

func _ready() -> void:
	var scorecard_index: int = 0
	for category in category_info_list:
		if category.id in starting_category_list:
			category_label_list[scorecard_index].text = category.name + ":"
			category_button_list[scorecard_index].text = str(category.base_score) + " + 0"
			category_button_list[scorecard_index].pressed.connect(category_button_pressed)
			
			category.label = category_label_list[scorecard_index]
			category.button = category_button_list[scorecard_index]
			
			active_category_info_list.append(category)
			scorecard_index += 1
	
	score_button.pressed.connect(_score_button_pressed)


func category_button_pressed() -> void:
	# Find which category was selected
	var current_category
	for category in active_category_info_list:
		if category.button.button_pressed:
			current_category = category
			break
	
	# Don't select category if zero

func _score_button_pressed() -> void:
	if Global.rerolls != 3:
		var current_category
		var category_selected: bool = false
		
		# Find which category was selected
		for category in active_category_info_list:
			if category.button.button_pressed:
				current_category = category
				category_selected = true
				break
		
		if category_selected:
			if current_category.total > 0:
				var scored_total = current_category.base_score + current_category.total
				current_category.scored = true
				current_category.button.disabled = true
				current_category.button.text = str(scored_total)
				Global.grand_total += scored_total
			
			update_labels.emit()
			update_game_status.emit(true)
			
		else:
			print("Please select a category")


func _on_update_scorecard() -> void:
	var scorecard_dice_list = []
	for dice in Global.rolling_dice_list:
		scorecard_dice_list.append(dice)
	for dice in Global.saved_dice_list:
		scorecard_dice_list.append(dice)
	
	for category in active_category_info_list:
		category.total = 0
		
		match category.id:
			Categories.ACES:
				for dice in scorecard_dice_list:
					if dice == 1:
						category.total += dice
			Categories.TWOS:
				for dice in scorecard_dice_list:
					if dice == 2:
						category.total += dice
			Categories.THREES:
				for dice in scorecard_dice_list:
					if dice == 3:
						category.total += dice
			Categories.FOURS:
				for dice in scorecard_dice_list:
					if dice == 4:
						category.total += dice
			Categories.TWO_PAIR:
				pass
			Categories.THREE_OF_A_KIND:
				pass
		
		category.button.text = str(category.base_score) + " + " + str(category.total)
