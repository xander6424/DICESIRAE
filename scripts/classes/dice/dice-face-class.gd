extends Resource

class_name DiceFace

@export var face_value: int = 1
@export var face_type: DiceData.FaceType = DiceData.FaceType.NORMAL


func _init(_face_value: int = 1, _face_type: DiceData.FaceType = DiceData.FaceType.NORMAL) -> void:
	face_value = _face_value
	face_type = _face_type
