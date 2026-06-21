extends Control

signal _update_round_status()

@onready var score_button: Button = %ScoreButton
@onready var lots_label: Label = %Lots
@onready var reroll_label: Label = %Rerolls
@onready var grand_total_label: Label = %Total
@onready var category_label_list = [%CategoryLabel1, %CategoryLabel2, %CategoryLabel3, %CategoryLabel4, %CategoryLabel5]
@onready var category_button_list = [%CategoryButton1, %CategoryButton2, %CategoryButton3, %CategoryButton4, %CategoryButton5]

enum Categories {ACES, TWOS, THREES, FOURS, TWO_PAIR, THREE_OF_A_KIND}
var starting_category_list: Array[Categories] = [Categories.ACES, Categories.TWOS, Categories.THREES, Categories.TWO_PAIR, Categories.THREE_OF_A_KIND]

class CategoryInfo:
	var name: String
	var level: int = 1
	var base_score: int
	var id: Categories
	
	var total: int = 0
	var scored: bool = false
	
	var label: Label = null
	var button: Button = null
	
	func _init(name: String, base_score: int, id: Categories):
		self.name = name
		self.base_score = base_score
		self.id = id

# Initialize category name, base score, and id
var aces: CategoryInfo = CategoryInfo.new("Aces", 5, Categories.ACES)
var twos: CategoryInfo = CategoryInfo.new("Twos", 5, Categories.TWOS)
var threes: CategoryInfo = CategoryInfo.new("Threes", 10, Categories.THREES)
var fours: CategoryInfo = CategoryInfo.new("Fours", 10, Categories.FOURS)
var two_pair: CategoryInfo = CategoryInfo.new("Two Pair", 20, Categories.TWO_PAIR)
var three_of_a_kind: CategoryInfo = CategoryInfo.new("Three of a Kind", 30, Categories.THREE_OF_A_KIND)

var category_info_list: Array[CategoryInfo] = [aces, twos, threes, fours, two_pair, three_of_a_kind]
var active_category_info_list: Array[CategoryInfo] = []

func _ready() -> void:
	var scorecard_index: int = 0
	for category in category_info_list:
		if category.id in starting_category_list:
			category_label_list[scorecard_index].text = category.name + ":"
			category_button_list[scorecard_index].text = str(category.base_score) + " + 0"
			#category_button_list[scorecard_index].pressed.connect(category_button_pressed)
			
			category.label = category_label_list[scorecard_index]
			category.button = category_button_list[scorecard_index]
			
			active_category_info_list.append(category)
			scorecard_index += 1
	
	score_button.pressed.connect(_score_button_pressed)
	_update_labels()

func _update_labels() -> void:
	lots_label.text = "Lots: " + str(Global.lots)
	reroll_label.text = "Rerolls: " + str(Global.rerolls)
	grand_total_label.text = "TOTAL: " + str(Global.grand_total)


func _score_button_pressed() -> void:
	if Global.rerolls != 3:
		var current_category: CategoryInfo
		var category_selected: bool = false
		
		# Find which category was selected
		for category in active_category_info_list:
			if category.button.button_pressed:
				current_category = category
				category_selected = true
				break
		
		if category_selected:
			if current_category.total > 0:
				var scored_total: int = current_category.base_score + current_category.total
				current_category.scored = true
				current_category.button.disabled = true
				current_category.button.text = str(scored_total)
				Global.grand_total += scored_total
				Global.current_lot_scored = true
				
				#Global.saved_dice_list.clear()
			
			_update_labels()
			_update_round_status.emit()
			
		else:
			print("Please select a category")


func _update_scorecard() -> void:
	var scorecard_dice_list: Array[int] = []
	
	for dice in Global.rolling_dice_list:
		scorecard_dice_list.append(dice)
	for dice in Global.saved_dice_list:
		scorecard_dice_list.append(dice)
	
	for category in active_category_info_list:
		category.total = 0
		
		if !category.scored:
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
							print("THERES A PAIR")
							category.total += dice * 2
							banned_face = dice
							pairs += 1
							
							# Exit if a two pair is found
							if pairs == 2:
								break
						
					# Reset score if no two pair is found
					if pairs < 2 and !four_of_a_kind:
						category.total = 0
				Categories.THREE_OF_A_KIND:
					for dice in scorecard_dice_list:
						if scorecard_dice_list.count(dice) >= 3:
							category.total += dice * 3
							break
			
			# Fix output
			category.button.text = str(category.base_score) + " + " + str(category.total)
