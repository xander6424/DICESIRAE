extends Node

const SHOP_FILE_PATH: String = "res://scenes/shop.tscn"
const SHOP_SCENE = preload(Global.SHOP_FILE_PATH)

const STARTING_LOTS: int = 3
const STARTING_REROLLS: int = 3
const STARTING_MONEY: int = 5
const ROLL_DURATION: float = 0.8

var lots: int = STARTING_LOTS
var rerolls: int = STARTING_REROLLS
var money: int = STARTING_MONEY
var grand_total: int = 0
var score_to_beat: int = 100 # Change to an array? How does score scaling work?

var rolling_dice_list: Array[int] = []
var saved_dice_list: Array[int] = []

var first_round_roll: bool = true
var current_lot_scored: bool = false
var round_won: bool = false
