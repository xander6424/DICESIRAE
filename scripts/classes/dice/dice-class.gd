extends Resource

class_name DiceInfo

@export var dice_size: DiceData.Size = DiceData.Size.D6
@export var dice_type: DiceData.DiceType = DiceData.DiceType.NORMAL
var faces: Array[DiceFace] = []

# current face index/value?


func _init(_dice_size: DiceData.Size = DiceData.Size.D6, _dice_type: DiceData.DiceType = DiceData.DiceType.NORMAL) -> void:
	dice_size = _dice_size
	dice_type = _dice_type
	
	if faces.is_empty():
		generate_default_faces()

func generate_default_faces() -> void:
	for i in range(1, dice_size + 1):
		faces.append(DiceFace.new(i, DiceData.FaceType.NORMAL))


func roll() -> int:
	# In here, just cycle through all sprites/numbers of
	# an array of size "DiceData.Size"??
	return 0

# Get current face?

# Upgrade face?

# Upgrade size?


func score_dice() -> int:
	return 0
