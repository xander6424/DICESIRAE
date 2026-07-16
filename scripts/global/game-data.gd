extends Node

signal _reset_round()


# Constant basic values
const STARTING_LOTS: int = 3
const STARTING_REROLLS: int = 3
const STARTING_MONEY: int = 5
const ROLL_DURATION: float = 1.0
const ROUND_SCORE_SCALING: Array[int] = [
	100, 150, 250, 
	500, 1200, 2400, 
	7800, 13500, 25000
]

var lots: int = STARTING_LOTS
var rerolls: int = STARTING_REROLLS
var bonus_lots: int = 0
var bonus_rerolls: int = 0
var money: int = STARTING_MONEY
var grand_total: int = 0
var score_to_beat: int = ROUND_SCORE_SCALING[0]

var total_add_score: int = 0
var total_mult_score: int = 0

var first_round_roll: bool = true
var current_lot_scored: bool = false
var round_won: bool = false
