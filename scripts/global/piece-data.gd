extends Node

const PIECE_POSITIONS: Array[Vector2] = [
	Vector2(25, -60),
	Vector2(-25, -30),
	Vector2(25, 0),
	Vector2(-25, 30),
	Vector2(25, 60)
]

var piece_hand_slots: Array = []
var max_piece_hand_size: int = 5


# Constant piece resources
const PAWN = preload("uid://dcnrojwwbbqqs")
const CHECKER = preload("uid://d0ad2ucf7321c")
const CHINESE_CHECKER = preload("uid://clamoo51stdfq")
const MANCALA_STONE = preload("uid://cv06ho5uqg750")
const HOUSE = preload("uid://c57wvbamdqd6s")
const FAMILY_CAR = preload("uid://bns4hgh8pp1ms")
const LOOSE_COIN = preload("uid://bf2qrbfnw2iyg")
const LADDER = preload("uid://xekun4e8jy6f")

# New piece stuff
const FULL_PIECE_LIST: Array[PieceInfo] = [
	PAWN,
	CHECKER,
	CHINESE_CHECKER,
	MANCALA_STONE,
	HOUSE,
	FAMILY_CAR,
	LOOSE_COIN,
	LADDER
]

# Piece ID
enum Piece {
	PAWN,
	CHECKER,
	CHINESE_CHECKER,
	MANCALA_STONE,
	HOUSE,
	FAMILY_CAR,
	LOOSE_COIN,
	LADDER
}
