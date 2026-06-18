extends Control

@onready var score_button: Button = %ScoreButton
@onready var category_label_list = [%CategoryLabel1, %CategoryLabel2, %CategoryLabel3, %CategoryLabel4, %CategoryLabel5]
@onready var category_button_list = [%CategoryButton1, %CategoryButton2, %CategoryButton3, %CategoryButton4, %CategoryButton5]

var game_scorecard_info = ["Aces", "Twos", "Threes", "Two Pair", "Three of a Kind"]

var category_score_updated: bool = false

func _ready() -> void:
	# Put each category name on scorecard
	var i = 0
	for category in category_label_list:
		category.text = game_scorecard_info[i]
		i += 1
	
	# Initialize button press functions and scores
	for category in category_button_list:
		category.text = "0"
		category.pressed.connect(category_button_pressed)
	score_button.pressed.connect(score_button_pressed)

func _process(delta: float) -> void:
	pass


func category_button_pressed() -> void:
	pass

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
