extends Node2D

@onready var score_label: Label = %Score
@onready var lots_label: Label = %Lots
@onready var reroll_label: Label = %Rerolls

var dice_in_play = 5
var roll_total = 0
var dice_rolled = 0
var lots = 3
var rerolls = 2
var playing = true

func _ready() -> void:
	update_score(roll_total)

func _process(delta: float) -> void:
	if rerolls <= 0:
		lots -= 1
		rerolls = 2
		update_score(roll_total)
		if lots <= 0:
			pass
		pass

func _on_dice_roll_done(roll: int) -> void:
	roll_total += roll
	dice_rolled += 1
	
	# Doesn't count a roll until all dice are scored
	if dice_rolled == dice_in_play:
		rerolls -= 1
		update_score(roll_total)
		
		# Reset for new roll
		dice_rolled = 0
		roll_total = 0

func update_score(score_total: int):
	score_label.text = str(score_total)
	lots_label.text = "Lots: " + str(lots)
	reroll_label.text = "Rerolls: " + str(rerolls)
	
# func enter_shop():
	# Buy random game piece
	# Return to game with reverted lot and reroll count
