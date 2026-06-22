extends Node2D

signal _update_labels()
signal _update_scorecard()
signal _save_button_pressed()

@onready var roll_button: TextureButton = %RollButton


func _ready() -> void:
	pass


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
		
		if Global.lots <= 0:
			roll_button.disabled = true
		
		# Manages win condition
		if Global.grand_total >= Global.score_to_beat:
			Global.round_won = true
			_change_scene_status(Global.round_won)
		elif Global.lots <= 0:
			_change_scene_status(Global.round_won)
	
	_update_labels.emit()
	_update_scorecard.emit()

func _change_scene_status(round_won: bool) -> void:
	if round_won:
		# Load the shop scene
		print("WIN!!!")
		
		var shop_instance: Control = Global.SHOP_SCENE.instantiate()
		shop_instance.position = Vector2(100, 0)
		get_tree().current_scene.add_child(shop_instance)
	else:
		# Load the game over scene
		print("LOSE.")
		pass
