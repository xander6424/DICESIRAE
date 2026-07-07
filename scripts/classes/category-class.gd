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
var exists_in_hand: bool = false # change to exists_in_hand
var exists_in_saved: bool = false

# Current label and button associated with a category
var label: Label = null
var button: Button = null

func check_hand_existance(dice_list: Array[DiceInfo]) -> bool: 
	return false

func score_category() -> int:
	return 0
