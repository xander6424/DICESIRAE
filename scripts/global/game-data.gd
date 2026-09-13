extends Node

signal _reset_round()


# Constant game values
const STARTING_LOTS: int = 3
const STARTING_REROLLS: int = 3
const STARTING_MONEY: int = 4
const ROLL_DURATION: float = 1.0
const ROUND_SCORE_SCALING: Array[int] = [
	100, 150, 250, # Ante1
	525, 950, 1775, # Ante2
	3900, 8650, 14500, #Ante3
	25000, 50000, 100000 #Ante4
]

# Internal game values
var round_number: int = 0
var bonus_lots: int = 0
var bonus_rerolls: int = 0
var grand_total: int = 0
var score_to_beat: int = ROUND_SCORE_SCALING[0]
var first_round_roll: bool = true
var current_lot_scored: bool = false
var round_won: bool = false

# Player-managed game values
var lots: int = STARTING_LOTS
var rerolls: int = STARTING_REROLLS
var money: int = STARTING_MONEY
