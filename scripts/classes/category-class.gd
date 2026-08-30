extends Resource

class_name CategoryInfo

@export var category_name: String
@export var id: CategoryData.Category

# (Base Score + Total Rolled) * Mult Score
@export var level: int = 1
@export var base_add_score: int = 0
@export var base_mult_score: int = 0

# Reset per time scored
var add_score: int = base_add_score
var mult_score: int = base_mult_score
var total: int = 0
var scored: bool = false

# Current label and button associated with a category & checking existance
var exists_in_hand: bool = false
var exists_in_saved: bool = false
var label: Label = null
var button: Button = null
var button_label: RichTextLabel = null

# Track which saved dice are valid to be scored in a category
var valid_dice_list: Array[DiceInfo] = []


func check_hand_existance(dice_list: Array[DiceInfo]) -> void: 
	dice_list.is_empty()

func check_saved_existance(dice_list: Array[DiceInfo]) -> void:
	dice_list.is_empty()

# REMOVE (after moving all categories away from this)
func score_category():
	pass
