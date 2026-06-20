extends Node2D

signal _update_labels()
signal _update_scorecard()

@onready var roll_button: TextureButton = %RollButton

#func _ready() -> void:
	#pass

func _update_round_status() -> void:
	# Checks if all rerolls have been used
	if Global.rerolls <= 0:
		roll_button.disabled = true
		
		# Append all remaining dice to saved list
		if Global.rolling_dice_list.size() != 0:
			for dice in Global.rolling_dice_list:
				Global.saved_dice_list.append(dice)
			Global.rolling_dice_list.clear()
		
		# Go to the shop after all lots used?
		if Global.lots <= 0:
			print("SHOP?")
	
	# Checks if a category has been scored
	if Global.current_lot_scored:
		Global.lots -= 1
		Global.rerolls = 3
		Global.current_lot_scored = false
		
	_update_labels.emit()
	_update_scorecard.emit()
