extends Resource

class_name CategoryInfo

@export var category_name: String
@export var id: CategoryData.Category

# (Base Score + Total Rolled) * Mult Score
@export var base_score: int
@export var mult_score: int

var level: int = 1
var total: int = 0
var scored: bool = false
var exists_in_hand: bool = false
var exists_in_saved: bool = false

var valid_dice_list: Array[DiceInfo] = []

# Current label and button associated with a category
var label: Label = null
var button: Button = null

func check_hand_existance(dice_list: Array[DiceInfo]) -> void: 
	dice_list.is_empty()

func check_saved_existance(dice_list: Array[DiceInfo]) -> void:
	dice_list.is_empty()

# REMOVE
func score_category():
	pass
