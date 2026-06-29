extends Node

class_name CategoryInfo

var category: String
var id: DiceData.Category
var level: int = 1
var scored: bool = false

# (Base Score + Total Rolled) * Mult Score
var base_score: int
var total: int = 0
var mult_score: int

# Current label and button associated with a category
var label: Label = null
var button: Button = null

func _init(_name: String, _base_score: int, _mult_score: int, _id: DiceData.Category):
	category = _name
	base_score = _base_score
	mult_score = _mult_score
	id = _id
