extends Resource

class_name DiceInfo

@export var size: DiceData.Size
@export var type: DiceData.DiceType
var faces: Array[int] = [1, 2, 3, 4, 5, 6]
# a variable type that can store both an int and face type?
# along with a function method?


func roll() -> int:
	# In here, just cycle through all sprites/numbers of
	# an array of size "DiceData.Size"??
	return 0

func save() -> void:
	pass

func score_dice() -> int:
	return 0
