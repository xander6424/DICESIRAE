extends Node2D

@onready var score_label: Label = %Score
@onready var lots_label: Label = %Lots
@onready var reroll_label: Label = %Rerolls
@onready var roll_button: TextureButton = %RollButton

var lots = 3
var rerolls = 3
var dice_in_play = 5
var roll_total = 0
var dice_rolled = 0
var rolling_dice_list = []
var saved_dice_list = []

# Altered with a button press on scorecard
var current_scored = false

func _ready() -> void:
	update_score(roll_total)
	update_labels()

func _process(delta: float) -> void:
	if rerolls <= 0:
		roll_button.disabled = true
		rerolls = 3
		
		# Append all remaining dice to saved list
		if rolling_dice_list.size() == 0:
			for dice in rolling_dice_list:
				saved_dice_list.append(dice)
			rolling_dice_list.clear()
		
		# Go to the shop after all lots used
		if lots <= 0:
			#roll_button.disabled = true
			enter_shop()
	
	if current_scored:
		lots -= 1
		update_labels() # after scoring actually happens
		current_scored = false

func _on_reset() -> void:
	# Reset for new roll when pressing the roll button
	dice_rolled = 0
	roll_total = 0
	rolling_dice_list.clear()


func _on_dice_roll_done(roll: int) -> void:
	dice_rolled += 1
	rolling_dice_list.append(roll)
	
	# Doesn't count a roll until all dice are scored
	if dice_rolled == dice_in_play:
		rerolls -= 1
		
		if rerolls > 0:
			roll_button.disabled = false
		
		# Add all dice (saved & unsaved) together
		for dice in rolling_dice_list:
			roll_total += dice
		for dice in saved_dice_list:
			roll_total += dice
		
		#dice_list.sort() for checking categories
		update_score(roll_total)
		update_labels()
		
		# Show numbers in output (remove later)
		print("DICE ROLLED: ", rolling_dice_list)
		print("DICE SAVED: ", saved_dice_list)


func update_score(score_total: int):
	score_label.text = str(score_total)

func update_labels():
	lots_label.text = "Lots: " + str(lots)
	reroll_label.text = "Rerolls: " + str(rerolls)


# SIGNAL CALL
func score_dice() -> bool:
	print("SCORING TIME")
	
	var scored = false
	
	return scored


func enter_shop():
	print("SHOP")


func _on_saved_pressed(number_rolled: int, saved: bool) -> void:
	var index = 0
	
	# Dice to be saved
	if saved:
		dice_in_play -= 1
		
		for dice in rolling_dice_list:
			if dice == number_rolled:
				print("APPENDED") # REMOVE
				saved_dice_list.append(number_rolled)
				rolling_dice_list.remove_at(index)
				break
			index += 1
	# Dice to be unsaved
	else:
		dice_in_play += 1
		
		for dice in saved_dice_list:
			if dice  == number_rolled:
				print("REMOVED") # REMOVE
				rolling_dice_list.append(number_rolled)
				saved_dice_list.remove_at(index)
				break
			index += 1
			
	# Show numbers in output (remove later)
	print("DICE ROLLED: ", rolling_dice_list)
	print("DICE SAVED: ", saved_dice_list)
