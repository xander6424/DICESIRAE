extends Node2D

signal _update_labels()

@onready var roll_button: TextureButton = %RollButton

#func _ready() -> void:
	#pass


func _update_round_status(current_roll_scored: bool) -> void:
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
			print("SHOP?")
	
	if current_roll_scored:
		Global.rerolls = 3
		
	_update_labels.emit()


func _on_update_round_status() -> void:
	pass # Replace with function body.
