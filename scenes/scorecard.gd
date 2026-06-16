extends Control

@onready var category_label_list = [%CategoryLabel1, %CategoryLabel2, %CategoryLabel3, %CategoryLabel4, %CategoryLabel5]
@onready var category_button_list = [%CategoryButton1, %CategoryButton2, %CategoryButton3, %CategoryButton4, %CategoryButton5]

var scorecard_info = ["Aces", "Twos", "Threes", "Two Pair", "Three of a Kind"]

func _ready() -> void:
	var i = 0
	for category in category_label_list:
		category.text = scorecard_info[i]
		i += 1

func _process(delta: float) -> void:
	pass
