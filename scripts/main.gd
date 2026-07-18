extends Node2D

signal _update_labels()
signal _reset_scorecard()
signal _update_scorecard()

@onready var background: ColorRect = %Background
@onready var roll_button: TextureButton = %RollButton
@onready var score_button: Button = %ScoreButton
@onready var intermission: Control = %Intermission
@onready var shop: Control = %Shop
@onready var game_over: Control = %GameOver

var round_number: int = 0
var shop_instance: Control

var god_mode: bool = false # REMOVE this later


func _ready() -> void:
	GameData._reset_round.connect(_on_reset_round)
	DiceManager._update_round_status.connect(_on_update_round_status)
	reset_game()
	_on_reset_round()

# Signal (not yet?) to fully reset the whole game
func reset_game() -> void:
	print("STARTING NEW GAME...")
	
	background.color = Color(0.22, 0.22, 0.22)
	
	DiceManager.create_starting_dice()

# Reset all labels, dice, and categories
func _on_reset_round() -> void:
	round_number += 1
	print("ROUND ", round_number, "\n")
	
	# Activate pieces at beginning of round (temporary location)
	GameData.bonus_lots = 0
	GameData.bonus_rerolls = 0
	
	PieceManager.round_started()
	
	GameData.lots = GameData.STARTING_LOTS + GameData.bonus_lots
	GameData.rerolls = GameData.STARTING_REROLLS + GameData.bonus_rerolls
	GameData.grand_total = 0
	GameData.score_to_beat = GameData.ROUND_SCORE_SCALING[round_number - 1]
	GameData.round_won = false
	
	# Reshuffle all discarded dice back into draw pile
	DiceManager.reset_round()
	
	if shop.visible:
		background.color = Color(0.22, 0.22, 0.22)
		shop.visible = false
		roll_button.disabled = false
		score_button.disabled = false
	
	_update_labels.emit()
	_reset_scorecard.emit()


# Checks the status of the current round after events happen
func _on_update_round_status() -> void:
	print("UPDATING ROUND STATUS\n")
	
	# Checks if all rerolls have been used
	if GameData.rerolls <= 0:
		roll_button.disabled = true
	
	# Checks if a category has been scored
	if GameData.current_lot_scored:
		print("LOT SCORED")
		
		GameData.lots -= 1
		GameData.rerolls = GameData.STARTING_REROLLS + GameData.bonus_rerolls
		GameData.first_round_roll = true
		GameData.current_lot_scored = false
		DiceManager.all_dice_list.clear()
		
		# Remove scored dice and replace them with drawn dice
		DiceManager.discard_dice()
		DiceManager.draw_dice()
		
		if GameData.lots <= 0:
			roll_button.disabled = true
		else:
			roll_button.disabled = false
		
		# Manages win condition
		if GameData.grand_total >= GameData.score_to_beat or god_mode:
			GameData.round_won = true
			roll_button.disabled = true
			score_button.disabled = true
			
			# TEMP GIVE MONEY
			GameData.money += 2
			
			_change_scene_status(GameData.round_won)
		elif GameData.lots <= 0:
			_change_scene_status(GameData.round_won)
	
	_update_labels.emit()
	_update_scorecard.emit()
	if shop.visible:
		_reset_scorecard.emit()


func _change_scene_status(round_won: bool) -> void:
	if round_won:
		print("WIN!!!\n")
		
		intermission.visible = true
	else:
		print("LOSE.\n")
		
		game_over.visible = true
		# Add a method to restart the game (call reset game)




# GOD MODE (Shift + G) - FOR DEBUGGING
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("God Mode"):
		GameData.current_lot_scored = true
		god_mode = true
		
		_on_update_round_status()
		
		god_mode = false
