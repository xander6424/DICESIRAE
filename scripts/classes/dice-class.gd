extends Resource

class_name DiceInfo

@export var size: DiceData.Size
@export var type: DiceData.DiceType
# var faces: Array[unique Face class] = []

func roll() -> int:
	# In here, just cycle through all sprites/numbers of an array of size "DiceData.Size"??
	return 0

func save() -> void:
	pass

func score_dice() -> int:
	return 0
