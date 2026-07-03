extends Node2D

signal _update_labels()
signal _reset_scorecard()
signal _update_scorecard()
signal _save_button_pressed()

@onready var roll_button: TextureButton = %RollButton
@onready var shop_block: ColorRect = %ShopBlock
@onready var game_over_label: Label = %GameOver
@onready var shop: Control = %Shop

var round_number: int = 0
var shop_instance: Control


func _ready() -> void:
	GameData._reset_round.connect(_on_reset_round)
	_on_reset_round()

# Signal to fully reset the whole game
func reset_game() -> void:
	pass

# Reset all labels, dice, and categories
func _on_reset_round() -> void:
	round_number += 1
	print("ROUND ", round_number)
	
	GameData.lots = GameData.STARTING_LOTS
	GameData.rerolls = GameData.STARTING_REROLLS
	GameData.grand_total = 0
	GameData.score_to_beat = GameData.ROUND_SCORE_SCALING[round_number - 1]
	GameData.round_won = false
	
	shop.visible = false
	shop_block.visible = false
	roll_button.disabled = false
	
	# Activate pieces at beginning of round
	for piece in GameData.active_piece_list:
		piece.round_started()
	
	_update_labels.emit()
	_reset_scorecard.emit()


func _update_round_status() -> void:
	# Checks if all rerolls have been used
	if GameData.rerolls <= 0:
		_save_button_pressed.emit() # Save all remaining dice
		roll_button.disabled = true
	
	# Checks if a category has been scored
	if GameData.current_lot_scored:
		GameData.lots -= 1
		GameData.rerolls = 3
		_save_button_pressed.emit() # Unsave all dice
		GameData.first_round_roll = true
		GameData.current_lot_scored = false
		
		if GameData.lots <= 0:
			roll_button.disabled = true
		
		# Manages win condition
		if GameData.grand_total >= GameData.score_to_beat:
			GameData.round_won = true
			roll_button.disabled = true
			_change_scene_status(GameData.round_won)
		elif GameData.lots <= 0:
			_change_scene_status(GameData.round_won)
	
	_update_labels.emit()
	_update_scorecard.emit()


func _change_scene_status(round_won: bool) -> void:
	if round_won:
		print("WIN!!!")
		shop_block.visible = true
		shop.visible = true
	else:
		print("LOSE.")
		# Load the game over scene
		shop_block.color = Color(25.397, 0.0, 0.0, 0.5)
		shop_block.visible = true
		game_over_label.visible = true
		pass





# GOD MODE (Shift + G) - FOR DEBUGGING
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("God Mode"):
		GameData.round_won = true
		_change_scene_status(GameData.round_won)
