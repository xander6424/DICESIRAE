extends Node

class_name CategoryInfo

var category_name: String
var id: DiceData.Category
var level: int = 1
var scored: bool = false

# (Base Score + Total Rolled) * Mult Score
var base_score: int
var mult_score: int
var total: int = 0

# Current label and button associated with a category
var label: Label = null
var button: Button = null

func check_validity() -> void:
	print("CHECKING IF VALID")
	pass

func score_category():
	pass

func _init(_name: String, _base_score: int, _mult_score: int, _id: DiceData.Category):
	category_name = _name
	base_score = _base_score
	mult_score = _mult_score
	id = _id
