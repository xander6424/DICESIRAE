extends Node2D

@onready var score: Label = %Score

var total = 0

func _ready() -> void:
	update_score(total)

func _on_dice_roll_done(index: int) -> void:
	total += index
	update_score(total)

func update_score(num: int):
	score.text = str(num)
