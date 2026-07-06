extends Node

signal _on_hand_drawn()

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

func draw_dice() -> void:
	while rolling_dice_list.size() < HAND_SIZE:
		if draw_pile.is_empty():
			break
		rolling_dice_list.append(draw_pile.pop_back())
	
	_on_hand_drawn.emit()


# Save and unsave dice here instead

# Roll fully finished (recieve signal to then activate main stuff)

# Discard hand
