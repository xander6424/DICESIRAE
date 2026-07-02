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

# Constant category values
const ACES = preload("uid://d0dnckugihorb")
const TWOS = preload("uid://bdli131rdnkn8")
const THREES = preload("uid://w1i6ic0hoa5l")
const FOURS = preload("uid://dkv7n3esqthwv")

const TWO_PAIR = preload("uid://c4cblgubhmop6")
const THREE_OF_A_KIND = preload("uid://dnd8frrk8gh6n")


var lots: int = STARTING_LOTS
var rerolls: int = STARTING_REROLLS
var money: int = STARTING_MONEY
var grand_total: int = 0
var score_to_beat: int = ROUND_SCORE_SCALING[0]

var rolling_dice_list: Array[int] = []
var saved_dice_list: Array[int] = []
var scoring_dice_list: Array[int] = []

var first_round_roll: bool = true
var current_lot_scored: bool = false
var round_won: bool = false

# New piece stuff
const FULL_PIECE_LIST: Array[PieceData] = [
	PAWN
]
var active_piece_list: Array[PieceData] = []

# New category stuff
const FULL_CATEGORY_LIST: Array[CategoryInfo] = [
	ACES,
	TWOS,
	THREES,
	FOURS,
	
	TWO_PAIR,
	THREE_OF_A_KIND
]
var active_category_info_list: Array[CategoryInfo] = []
