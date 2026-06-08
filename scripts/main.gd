extends Node2D

@onready var score_label: Label = %Score
@onready var lots_label: Label = %Lots
@onready var reroll_label: Label = %Rerolls

# Use this???
@onready var dice_set: Node2D = $"Dice Set"

var dice_in_play = 5
var roll_total = 0
var dice_rolled = 0
var lots = 3
var rerolls = 2
var playing = true

func _ready() -> void:
	update_score(roll_total)
	update_labels()

func _process(delta: float) -> void:
	if playing:
		if rerolls <= 0:
			lots -= 1
			rerolls = 2
			update_labels()
			 
			if lots <= 0:
				# No more rolling, then
				playing = false
				enter_shop()

func _on_dice_roll_done(roll: int) -> void:
	roll_total += roll
	dice_rolled += 1
	
	# Doesn't count a roll until all dice are scored
	if dice_rolled == dice_in_play:
		rerolls -= 1
		update_score(roll_total)
		update_labels()
		
		# Reset for new roll
		dice_rolled = 0
		roll_total = 0

func update_score(score_total: int):
	score_label.text = str(score_total)
	
func update_labels():
	lots_label.text = "Lots: " + str(lots)
	reroll_label.text = "Rerolls: " + str(rerolls)
	
func enter_shop():
	print("SHOP")
