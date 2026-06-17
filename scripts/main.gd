extends Node2D

@onready var score_label: Label = %Score
@onready var lots_label: Label = %Lots
@onready var reroll_label: Label = %Rerolls
@onready var roll_button: TextureButton = %RollButton

var dice_in_play = 5
var roll_total = 0
var dice_rolled = 0
var reroll_checked: bool = false

# Altered with a button press on scorecard
var current_roll_scored = false

func _ready() -> void:
	update_score(roll_total)
	update_labels()

func _process(delta: float) -> void:
	# Checks if all rerolls have been used
	if Global.rerolls <= 0 and !reroll_checked:
		roll_button.disabled = true
		reroll_checked = true
		
		# Append all remaining dice to saved list
		if Global.rolling_dice_list.size() != 0:
			for dice in Global.rolling_dice_list:
				Global.saved_dice_list.append(dice)
			Global.rolling_dice_list.clear()
		
		# Go to the shop after all lots used
		if Global.lots <= 0:
			#roll_button.disabled = true
			enter_shop()
	
	if current_roll_scored:
		Global.rerolls = 3
		Global.lots -= 1
		update_labels() # after scoring actually happens
		current_roll_scored = false

func _on_reset() -> void:
	# Reset for new roll when pressing the roll button
	dice_rolled = 0
	roll_total = 0
	Global.roll_completed = false
	Global.rolling_dice_list.clear()


func _on_dice_roll_done(roll: int) -> void:
	dice_rolled += 1
	Global.rolling_dice_list.append(roll)
	
	# Doesn't count a roll until all dice are scored
	if dice_rolled == dice_in_play:
		Global.rerolls -= 1
		Global.roll_completed = true
		
		if Global.rerolls > 0:
			roll_button.disabled = false
		
		# Add all dice (saved & unsaved) together
		for dice in Global.rolling_dice_list:
			roll_total += dice
		for dice in Global.saved_dice_list:
			roll_total += dice
		
		#dice_list.sort() for checking categories
		update_score(roll_total)
		update_labels()
		
		# Show numbers in output (remove later)
		print("DICE ROLLED: ", Global.rolling_dice_list)
		print("DICE SAVED: ", Global.saved_dice_list)


func update_score(score_total: int):
	score_label.text = str(score_total)

func update_labels():
	lots_label.text = "Lots: " + str(Global.lots)
	reroll_label.text = "Rerolls: " + str(Global.rerolls)


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
		
		for dice in Global.rolling_dice_list:
			if dice == number_rolled:
				print("APPENDED") # REMOVE
				Global.saved_dice_list.append(number_rolled)
				Global.rolling_dice_list.remove_at(index)
				break
			index += 1
	# Dice to be unsaved
	else:
		dice_in_play += 1
		
		for dice in Global.saved_dice_list:
			if dice  == number_rolled:
				print("REMOVED") # REMOVE
				Global.rolling_dice_list.append(number_rolled)
				Global.saved_dice_list.remove_at(index)
				break
			index += 1
			
	# Show numbers in output (remove later)
	print("DICE ROLLED: ", Global.rolling_dice_list)
	print("DICE SAVED: ", Global.saved_dice_list)
