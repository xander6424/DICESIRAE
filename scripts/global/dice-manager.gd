extends Node

signal _on_hand_drawn()
signal _on_dice_discarded(discarded_dice_list: Array[DiceInfo], dice_slots: Array)
signal _force_unsave(dice: DiceInfo)
signal _hand_rolling_done()
signal _update_round_status()

const MAX_HAND_SIZE: int = 5
const MAX_DRAW_PILE_SIZE: int = 10

var draw_pile: Array[DiceInfo] = []
var all_dice_list: Array[DiceInfo] = [] # Contains all dice for checking
var scoring_dice_list: Array[DiceInfo] = [] # Contains valid dice for checking
var rolling_dice_list: Array[DiceInfo] = []
var saved_dice_list: Array[DiceInfo] = []
var discard_pile: Array[DiceInfo] = []


func _ready() -> void:
	_hand_rolling_done.connect(_on_hand_rolling_done)

func create_starting_dice() -> void:
	draw_pile.clear()
	all_dice_list.clear()
	scoring_dice_list.clear()
	rolling_dice_list.clear()
	saved_dice_list.clear()
	discard_pile.clear()
	
	for i in range(MAX_DRAW_PILE_SIZE):
		draw_pile.append(DiceInfo.new())
	
	draw_pile.shuffle()

func reset_round() -> void:
	# Discard all remaining dice in hand
	_on_dice_discarded.emit(rolling_dice_list, DiceData.dice_hand_slots)
	
	# Move all dice to draw pile and shuffle
	draw_pile.append_array(discard_pile)
	draw_pile.shuffle()
	discard_pile.clear()
	
	draw_dice()


func draw_dice() -> void:
	while rolling_dice_list.size() < MAX_HAND_SIZE:
		if draw_pile.is_empty():
			break
		rolling_dice_list.append(draw_pile.pop_back())
	
	_on_hand_drawn.emit()

func discard_dice() -> void:
	var discarded_dice_list: Array[DiceInfo] = []
	var unscored_dice_list: Array[DiceInfo] = []
	
	# Only discard valid dice that were used in scoring
	for dice in saved_dice_list:
		if dice.scored:
			discard_pile.append(dice)
			discarded_dice_list.append(dice)
			dice.scored = false
		else:
			unscored_dice_list.append(dice)
	
	saved_dice_list.clear()
	rolling_dice_list.append_array(unscored_dice_list)
	
	# Visually unsave all invalid dice nodes
	for dice in unscored_dice_list:
		_force_unsave.emit(dice)
	
	_on_dice_discarded.emit(discarded_dice_list, DiceData.dice_saved_slots)


func _on_hand_rolling_done() -> void:
	print("HAND DONE ROLLING")
	
	# Move all rolled/saved dice in a scoring list to be checked
	all_dice_list.clear()
	for dice in rolling_dice_list:
		all_dice_list.append(dice)
	for dice in saved_dice_list:
		all_dice_list.append(dice)
	
	_update_round_status.emit()


# Save dice data only
func save_dice(dice: DiceInfo) -> void:
	if rolling_dice_list.has(dice):
		rolling_dice_list.erase(dice)
		saved_dice_list.append(dice)
		
		# Check if category exists in saved
		_update_round_status.emit()

# Unsave dice data only
func unsave_dice(dice: DiceInfo) -> void:
	if saved_dice_list.has(dice):
		saved_dice_list.erase(dice)
		rolling_dice_list.append(dice)
		
		# Check if category exists in saved
		_update_round_status.emit()
