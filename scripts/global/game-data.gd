extends Node

signal _reset_round()

# Constant basic values
const STARTING_LOTS: int = 3
const STARTING_REROLLS: int = 3
const STARTING_MONEY: int = 5
const ROLL_DURATION: float = 0.8
const ROUND_SCORE_SCALING: Array[int] = [100, 150, 250, 500, 1200]

# Constant piece values
const PAWN = preload("uid://dcnrojwwbbqqs")

const ACES = preload("uid://d0dnckugihorb")


var lots: int = STARTING_LOTS
var rerolls: int = STARTING_REROLLS
var money: int = STARTING_MONEY
var grand_total: int = 0
var score_to_beat: int = ROUND_SCORE_SCALING[0]

var rolling_dice_list: Array[int] = []
var saved_dice_list: Array[int] = []

var first_round_roll: bool = true
var current_lot_scored: bool = false
var round_won: bool = false

# New piece stuff
const FULL_PIECES_LIST: Array[PieceData] = [
	PAWN
]
var active_piece_list: Array[PieceData] = []

const FULL_CATEGORIES_LIST: Array[CategoryInfo] = [
	ACES
]
