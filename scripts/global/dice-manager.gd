extends Node

const HAND_SIZE: int = 5
const STARTING_DRAW_PILE_SIZE: int = 10

var draw_pile: Array[DiceInfo] = []
var rolling_dice_list: Array[DiceInfo] = []
var saved_dice_list: Array[DiceInfo] = []
var discard_pile: Array[DiceInfo] = []
