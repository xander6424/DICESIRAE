extends Node2D

signal update_scorecard()

@onready var score_label: Label = %Score
@onready var roll_button: TextureButton = %RollButton

var dice_in_play: int = 5
var dice_rolled: int = 0

func _ready() -> void:
	pass

func _on_reset() -> void:
	# Reset for new roll when pressing the roll button
	dice_rolled = 0
	Global.rolling_dice_list.clear()


func _update_game_status(current_roll_scored: bool) -> void:
	# Checks if all rerolls have been used
	if Global.rerolls <= 0:
		roll_button.disabled = true
		
		# Append all remaining dice to saved list
		if Global.rolling_dice_list.size() != 0:
			for dice in Global.rolling_dice_list:
				Global.saved_dice_list.append(dice)
			Global.rolling_dice_list.clear()
		
		# Go to the shop after all lots used
		if Global.lots <= 0:
			enter_shop() # changes scene
	
	if current_roll_scored:
		Global.rerolls = 3
		Global.lots -= 1


func _on_dice_roll_done(roll: int) -> void:
	dice_rolled += 1
	Global.rolling_dice_list.append(roll)
	
	# Doesn't count a roll until all dice are scored
	if dice_rolled == dice_in_play:
		Global.rerolls -= 1
		update_scorecard.emit()
		
		if Global.rerolls > 0:
			roll_button.disabled = false
		
		_update_game_status(false)
		
		
		# Show numbers in output (remove later)
		print("DICE ROLLED: ", Global.rolling_dice_list)
		print("DICE SAVED: ", Global.saved_dice_list)


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
	
	if Global.rolling_dice_list.is_empty():
		roll_button.disabled = true
	else:
		roll_button.disabled = false
