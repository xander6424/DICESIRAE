extends Resource

class_name CategoryInfo

@export var category_name: String
@export var id: CategoryData.Category

# (Base Score + Total Rolled) * Mult Score
@export var base_score: int
@export var mult_score: int

var level: int = 1
var valid: bool = false
var scored: bool = false
var total: int = 0

# Current label and button associated with a category
var label: Label = null
var button: Button = null

func check_validity() -> void: pass

func score_category() -> int:
	return 0
