extends Resource

class_name DiceInfo

@export var dice_size: DiceData.Size = DiceData.Size.D6
@export var dice_type: DiceData.DiceType = DiceData.DiceType.NORMAL
var faces: Array[DiceFace] = []
var current_face_index: int = 0 # make this random?


func _init(_dice_size: DiceData.Size = DiceData.Size.D6, _dice_type: DiceData.DiceType = DiceData.DiceType.NORMAL) -> void:
	dice_size = _dice_size
	dice_type = _dice_type
	
	if faces.is_empty():
		generate_default_faces()

func generate_default_faces() -> void:
	for i in range(1, dice_size + 1):
		faces.append(DiceFace.new(i, DiceData.FaceType.NORMAL))

func get_current_face() -> DiceFace:
	return faces[current_face_index]


func roll() -> DiceFace:
	current_face_index = randi() % faces.size()
	return faces[current_face_index]

# Get current face?

# Upgrade face?

# Upgrade size?


func score_dice() -> int:
	return 0
