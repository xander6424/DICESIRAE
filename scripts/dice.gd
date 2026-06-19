extends RigidBody2D

#signal roll_done(index: int)
#signal saved_pressed(number_rolled: int, saved: bool)
signal update_scorecard()

@onready var faces: Node2D = %Faces
@onready var roll_button: TextureButton = %RollButton
@onready var save_button: Button = %SaveButton

var dice_in_play: int = 5
var total_dice_rolled: int = 0
var number_rolled: int = 0
var rolling: bool = false
var dice_saved: bool = false

func _ready() -> void:
	for face in faces.get_children():
		face.hide()
	
	# Select a starting face at random
	var starting_index: int = faces.get_children().pick_random().get_index()
	faces.get_child(starting_index).show()
	
	roll_button.pressed.connect(roll_button_pressed)
	save_button.pressed.connect(_save_button_pressed)

# FIX THIS SYSTEM
func _process(delta: float) -> void:
	if Global.rerolls <= 0 and save_button.disabled == false:
		_save_button_pressed()
		save_button.disabled = true


func roll_button_pressed():
	if !rolling and !dice_saved:
		# Reset necessary variables
		total_dice_rolled = 0
		Global.rolling_dice_list.clear()
		
		roll_button.disabled = true
		roll_dice()

func roll_dice():
	rolling = true
	
	var duration: float = Global.ROLL_DURATION
	var current_index: int = 0
	var new_index: int = 0
	
	# Roll the dice
	while duration > 0:
		# Prevent duplicate faces from being shown in a row
		while current_index == new_index:
			new_index = faces.get_children().pick_random().get_index()
		
		faces.get_child(current_index).hide()
		faces.get_child(new_index).show()
		
		await get_tree().create_timer(0.1).timeout
		
		current_index = new_index
		duration -= 0.1
	
	# Finish rolling dice and add it to the list
	rolling = false
	total_dice_rolled += 1
	number_rolled = current_index + 1
	Global.rolling_dice_list.append(number_rolled)
	
	print(total_dice_rolled, " == ", dice_in_play)
	
	# Doesn't count a roll until all dice are scored
	if total_dice_rolled == dice_in_play:
		Global.rerolls -= 1
		update_scorecard.emit()
		
		if Global.rerolls > 0:
			roll_button.disabled = false
		
		#_update_round_status(false)
		
		
		# Show numbers in output (remove later)
		print("DICE ROLLED: ", Global.rolling_dice_list)
		print("DICE SAVED: ", Global.saved_dice_list)


func _save_button_pressed():
	if !rolling:
		if !dice_saved:
			dice_saved = true
			position.y += 25
		elif dice_saved and Global.rerolls > 0: # Then I don't need to disable?
			dice_saved = false
			position.y -= 25
		
	
	# OLD FUNCTION
	
	var index: int = 0
	
	# Dice to be saved
	if dice_saved:
		dice_in_play -= 1
		
		for dice in Global.rolling_dice_list:
			if dice == number_rolled:
				Global.saved_dice_list.append(number_rolled)
				Global.rolling_dice_list.remove_at(index)
				break
			index += 1
	# Dice to be unsaved
	else:
		dice_in_play += 1
		
		for dice in Global.saved_dice_list:
			if dice  == number_rolled:
				Global.rolling_dice_list.append(number_rolled)
				Global.saved_dice_list.remove_at(index)
				break
			index += 1
	
	if Global.rolling_dice_list.is_empty():
		roll_button.disabled = true
	else:
		roll_button.disabled = false
