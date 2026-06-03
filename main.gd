extends Node2D

@onready var score_label: Label = %Score
@onready var rolls_label: Label = %Rolls

var dice_in_play = 5
var roll_total = 0
var dice_rolled = 0
var rolls = 3

func _ready() -> void:
	update_score(roll_total)

func _on_dice_roll_done(roll: int) -> void:
	roll_total += roll
	dice_rolled += 1
	
	if dice_rolled == dice_in_play:
		rolls -= 1
		update_score(roll_total)
		
		# Reset for new roll
		dice_rolled = 0
		roll_total = 0

func update_score(score_total: int):
	score_label.text = str(score_total)
	rolls_label.text = "Rolls: " + str(rolls)
