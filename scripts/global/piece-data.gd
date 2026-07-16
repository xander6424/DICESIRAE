extends Node

const PIECE_POSITIONS: Array[Vector2] = [
	Vector2(50, -100),
	Vector2(-50, -50),
	Vector2(50, 0),
	Vector2(-50, 50),
	Vector2(50, 100)
]


# Constant piece resources
const PAWN = preload("uid://dcnrojwwbbqqs")
const MANCALA_STONE = preload("uid://cv06ho5uqg750")
const LADDER = preload("uid://xekun4e8jy6f")

# New piece stuff
const FULL_PIECE_LIST: Array[PieceInfo] = [
	PAWN,
	MANCALA_STONE,
	LADDER
]

# Piece ID
enum Piece {
	PAWN,
	MANCALA_STONE,
	LADDER
}
