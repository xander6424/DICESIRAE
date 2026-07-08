extends Node

signal _on_hand_drawn()
signal _on_saved_discarded()
signal _hand_rolling_done()
signal _update_round_status()

const HAND_SIZE: int = 5
const STARTING_DRAW_PILE_SIZE: int = 10

var draw_pile: Array[DiceInfo] = []
var rolling_dice_list: Array[DiceInfo] = []
var saved_dice_list: Array[DiceInfo] = []
var discard_pile: Array[DiceInfo] = []

var all_dice_list: Array[DiceInfo] = []


func _ready() -> void:
	_hand_rolling_done.connect(_on_hand_rolling_done)

func create_starting_dice() -> void:
	draw_pile.clear()
	rolling_dice_list.clear()
	saved_dice_list.clear()
	all_dice_list.clear()
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

func discard_dice() -> void:
	for dice in saved_dice_list:
		if dice.scored:
			discard_pile.append(dice)
			dice.scored = false
		else:
			rolling_dice_list.append(dice)
	
	saved_dice_list.clear()
	
	_on_saved_discarded.emit()

func _on_hand_rolling_done() -> void:
	print("HAND DONE ROLLING")
	
	# Move all rolled/saved dice in a scoring list to be checked
	all_dice_list.clear()
	for dice in rolling_dice_list:
		all_dice_list.append(dice)
	for dice in saved_dice_list:
		all_dice_list.append(dice)
	
	_update_round_status.emit()


func save_dice(dice: DiceInfo) -> void:
	if rolling_dice_list.has(dice):
		rolling_dice_list.erase(dice)
		saved_dice_list.append(dice)
		
		# Check if category exists in saved
		_update_round_status.emit()

func unsave_dice(dice: DiceInfo) -> void:
	if saved_dice_list.has(dice):
		saved_dice_list.erase(dice)
		rolling_dice_list.append(dice)
		
		# Check if category exists in saved
		_update_round_status.emit()
