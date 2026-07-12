extends Resource

class_name PieceInfo

@export var piece_id: PieceData.Piece
@export var piece_name: String = ""
@export var piece_description: String = ""
@export var texture: Texture2D
@export var sell_value: int

var using: bool = false

# [ADD Value, MULT Value]
var score_values: Array[int] = [0, 0]


func piece_scored() -> Array[int]: return [0, 0]

func dice_scored() -> Array[int]: return [0, 0]

func round_started(): pass

func round_ended(): pass

func sell() -> int: return 0

func reset_values() -> void: pass
