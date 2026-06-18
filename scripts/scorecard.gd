extends Control

@onready var score_button: Button = %ScoreButton
@onready var category_label_list = [%CategoryLabel1, %CategoryLabel2, %CategoryLabel3, %CategoryLabel4, %CategoryLabel5]
@onready var category_button_list = [%CategoryButton1, %CategoryButton2, %CategoryButton3, %CategoryButton4, %CategoryButton5]

enum Categories {ACES, TWOS, THREES, FOURS, TWO_PAIR, THREE_OF_A_KIND}
var starting_category_list = [Categories.ACES, Categories.TWOS, Categories.THREES, Categories.TWO_PAIR, Categories.THREE_OF_A_KIND]

class CategoryInfo:
	var name: String
	var base_score: int
	var id: Categories
	var scored: bool = false
	
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

func _ready() -> void:
	var scorecard_index: int = 0
	for category in category_info_list:
		if category.id in starting_category_list:
			category_label_list[scorecard_index].text = category.name
			category_button_list[scorecard_index].text = str(category.base_score) + " + 0"
			category_button_list[scorecard_index].pressed.connect(category_button_pressed)
			scorecard_index += 1
	
	score_button.pressed.connect(score_button_pressed)


func category_button_pressed() -> void:
	print("PRESSED")

func score_button_pressed() -> void:
	var category_selected: bool = false
	
	# Find which category was selected
	for button in category_button_list:
		if button.button_pressed:
			category_selected = true
			break
	
	if category_selected:
		print("Scoring category")
	else:
		print("Please select a category")


func _on_update_scorecard() -> void:
	var aces_total = 0
	var twos_total = 0
	var threes_total = 0
	
	# Aces
	for dice in Global.rolling_dice_list:
		if dice == 1:
			aces_total += dice
	for dice in Global.saved_dice_list:
		if dice == 1:
			aces_total += dice
	
	# Twos
	for dice in Global.rolling_dice_list:
		if dice == 2:
			twos_total += dice
	for dice in Global.saved_dice_list:
		if dice == 2:
			twos_total += dice
	
	# Threes
	for dice in Global.rolling_dice_list:
		if dice == 3:
			threes_total += dice
	for dice in Global.saved_dice_list:
		if dice == 3:
			threes_total += dice
	
	category_button_list[0].text = str(aces_total)
	category_button_list[1].text = str(twos_total)
	category_button_list[2].text = str(threes_total)
