extends Resource

class_name DiceInfo

@export var size: DiceData.Size
@export var type: DiceData.DiceType
# var faces: Array[unique Face class] = []

func roll() -> int:
	return 0

func save() -> void:
	pass

func score_dice() -> int:
	return 0
