extends Node

# Constant piece resources
const PAWN = preload("uid://dcnrojwwbbqqs")
const LADDER = preload("uid://xekun4e8jy6f")

# New piece stuff
const FULL_PIECE_LIST: Array[PieceInfo] = [
	PAWN,
	LADDER
]

# Piece ID
enum Piece {
	PAWN,
	LADDER
}
