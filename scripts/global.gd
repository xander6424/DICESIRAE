extends Node

const STARTING_LOTS: int = 3
const STARTING_REROLLS: int = 3
const ROLL_DURATION: float = 0.8

var lots: int = STARTING_LOTS
var rerolls: int = STARTING_REROLLS
var grand_total: int = 0
var rolling_dice_list: Array[int] = []
var saved_dice_list: Array[int] = []
var first_round_roll: bool = true
var current_lot_scored: bool = false
