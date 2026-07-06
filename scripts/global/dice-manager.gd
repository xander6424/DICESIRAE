extends Node

const HAND_SIZE: int = 5
const STARTING_DRAW_PILE_SIZE: int = 10

var draw_pile: Array[DiceInfo] = []
var rolling_dice_list: Array[DiceInfo] = []
var saved_dice_list: Array[DiceInfo] = []
var discard_pile: Array[DiceInfo] = []


func create_starting_dice() -> void:
	draw_pile.clear()
	rolling_dice_list.clear()
	saved_dice_list.clear()
	discard_pile.clear()
	
	for i in range(STARTING_DRAW_PILE_SIZE):
		draw_pile.append(DiceInfo.new())
	
	draw_pile.shuffle()
	print(draw_pile)
