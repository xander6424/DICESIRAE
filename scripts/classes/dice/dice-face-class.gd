extends Resource

class_name DiceFace

var face_index: int
var face_texture: Texture2D
@export var face_value: int = 1
@export var face_type: DiceData.FaceType = DiceData.FaceType.NORMAL


func _init(_face_value: int, _face_type: DiceData.FaceType, _face_texture: Texture2D) -> void:
	face_value = _face_value
	face_type = _face_type
	face_texture = _face_texture

# Scoring/activation function?
