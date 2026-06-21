extends Node2D

signal _update_labels()
signal _update_scorecard()
signal _save_button_pressed()

@onready var roll_button: TextureButton = %RollButton

func _update_round_status() -> void:
	# Checks if all rerolls have been used
	if Global.rerolls <= 0:
		_save_button_pressed.emit() # Save all dice
		roll_button.disabled = true
	
	# Checks if a category has been scored
	if Global.current_lot_scored:
		Global.lots -= 1
		Global.rerolls = 3
		_save_button_pressed.emit() # Unsave all dice
		Global.first_round_roll = true
		Global.current_lot_scored = false
	
	# Go to the shop after all lots used?
	if Global.lots <= 0:
		roll_button.disabled = true
		print("SHOP?")
	
	_update_labels.emit()
	_update_scorecard.emit()
