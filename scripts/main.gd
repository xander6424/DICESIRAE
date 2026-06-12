extends Node2D

@onready var score_label: Label = %Score
@onready var lots_label: Label = %Lots
@onready var reroll_label: Label = %Rerolls
@onready var roll_button: TextureButton = %RollButton

var dice_in_play = 5
var roll_total = 0
var dice_rolled = 0
var rolling_dice_list = []
var saved_dice_list = []
var lots = 3
var rerolls = 2

func _ready() -> void:
	update_score(roll_total)
	update_labels()

func _process(delta: float) -> void:
	if rerolls <= 0:
		
		# Append all remaining dice to saved
		
		lots -= 1
		rerolls = 2
		update_labels()
		 
		if lots <= 0:
			# No more rolling, then
			roll_button.disabled = true
			enter_shop()

func _on_reset() -> void:
	# Reset for new roll
	dice_rolled = 0
	roll_total = 0
	rolling_dice_list.clear()


func _on_dice_roll_done(roll: int) -> void:
	roll_total += roll
	dice_rolled += 1
	rolling_dice_list.append(roll)
	
	# Doesn't count a roll until all dice are scored
	if dice_rolled == dice_in_play:
		rerolls -= 1
		#dice_list.sort() for checking categories
		update_score(roll_total)
		update_labels()
		
		print("DICE ROLLED: ", rolling_dice_list) # Show numbers in output
		print("DICE SAVED: ", saved_dice_list)


func update_score(score_total: int):
	score_label.text = str(score_total)
	
func update_labels():
	lots_label.text = "Lots: " + str(lots)
	reroll_label.text = "Rerolls: " + str(rerolls)
	
func enter_shop():
	print("SHOP")


func _on_saved_pressed(number_rolled: int) -> void:
	dice_in_play -= 1
	
	for dice in rolling_dice_list:
		if dice == number_rolled:
			print("APPENDED") # REMOVE
			saved_dice_list.append(number_rolled)
			break
