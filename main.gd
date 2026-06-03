extends Node2D

@onready var score_label: Label = %Score

var roll_total = 0

func _on_dice_roll_done(roll: int) -> void:
	roll_total = roll
	update_score(roll_total)

func update_score(score_total: int):
	score_label.text = str(score_total)
