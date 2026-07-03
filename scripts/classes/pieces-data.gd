extends Resource

class_name PieceData

@export var piece_id: DiceData.Piece
@export var piece_name: String = ""
@export var piece_description: String = ""
@export var texture: Texture2D

@export var sell_value: int
var using: bool = false


func piece_scored(): pass

func dice_scored(): pass

func round_started(): pass

func round_ended(): pass
