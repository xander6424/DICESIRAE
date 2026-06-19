extends RigidBody2D

#signal roll_done(index: int)
#signal saved_pressed(number_rolled: int, saved: bool)

@onready var faces: Node2D = %Faces
@onready var roll_button: TextureButton = %RollButton
@onready var save_button: Button = %SaveButton

var dice_in_play: int = 5
var dice_rolled: int = 0

var number_rolled = 0
var current_index = 0
var new_index = 0
var rolling = false
var saved = false

func _ready() -> void:
	for face in faces.get_children():
		face.hide()
	
	# Select a starting face at random
	var starting_index = faces.get_children().pick_random().get_index()
	faces.get_child(starting_index).show()
	
	roll_button.pressed.connect(roll_button_pressed)
	save_button.pressed.connect(_save_button_pressed)

func _process(delta: float) -> void:
	if Global.rerolls <= 0 and save_button.disabled == false:
		_save_button_pressed()
		save_button.disabled = true


func roll_button_pressed():
	if !rolling and !saved:
		# Reset necessary variables
		dice_rolled = 0
		Global.rolling_dice_list.clear()
		
		roll_button.disabled = true
		_roll_dice()

func _roll_dice():
	var duration = 0.8
	rolling = true
	
	while duration > 0:
		# Prevent duplicate faces from being shown in a row
		while current_index == new_index:
			new_index = faces.get_children().pick_random().get_index()
		
		faces.get_child(current_index).hide()
		faces.get_child(new_index).show()
		
		await get_tree().create_timer(0.1).timeout
		
		current_index = new_index
		duration -= 0.1
	
	number_rolled = current_index + 1
	rolling = false
	
	# OLD FUNCTION
	
	dice_rolled += 1
	Global.rolling_dice_list.append(number_rolled)
	
	# Doesn't count a roll until all dice are scored
	if dice_rolled == dice_in_play:
		Global.rerolls -= 1
		update_scorecard.emit()
		
		if Global.rerolls > 0:
			roll_button.disabled = false
		
		_update_round_status(false)
		
		
		# Show numbers in output (remove later)
		print("DICE ROLLED: ", Global.rolling_dice_list)
		print("DICE SAVED: ", Global.saved_dice_list)


func _save_button_pressed():
	if !rolling:
		if !saved:
			saved = true
			position.y += 25
		elif saved and Global.rerolls > 0:
			saved = false
			position.y -= 25
		
	
	# OLD FUNCTION
	
	var index: int = 0
	
	# Dice to be saved
	if saved:
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
