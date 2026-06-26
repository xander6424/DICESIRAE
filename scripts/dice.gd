extends RigidBody2D

signal _update_round_status()

@onready var faces: Node2D = %Faces
@onready var roll_button: TextureButton = %RollButton
@onready var save_button: TextureButton = %SaveButton

static var total_dice_rolled: int = 0
static var dice_in_play: int = 5
static var any_dice_rolling = false
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


func roll_button_pressed():
	if !rolling and !dice_saved:
		Global.rolling_dice_list.clear()
		Global.first_round_roll = false
		
		roll_button.disabled = true
		any_dice_rolling = true
		roll_dice()

func roll_dice():
	rolling = true
	
	var duration: float = Global.ROLL_DURATION
	var current_index: int = faces.get_children().find(faces.get_children().filter(func(f): return f.visible)[0])
	var face_count: int = faces.get_child_count()
	
	# Roll the dice
	while duration > 0:
		var new_index: int = current_index
		
		# Prevent duplicate faces from being shown in a row
		while current_index == new_index:
			new_index = randi() % face_count
		
		faces.get_child(current_index).hide()
		faces.get_child(new_index).show()
		current_index = new_index
		
		await get_tree().create_timer(0.1).timeout
		duration -= 0.1
	
	# Finish rolling dice and add it to the list
	rolling = false
	total_dice_rolled += 1
	number_rolled = int(faces.get_child(current_index).name)
	Global.rolling_dice_list.append(number_rolled)
	
	# Doesn't count a roll until all dice are scored
	if total_dice_rolled == dice_in_play:
		Global.rerolls -= 1
		total_dice_rolled = 0
		any_dice_rolling = false
		
		if Global.rerolls > 0:
			roll_button.disabled = false
		
		_update_round_status.emit()
		
		# Show numbers in output (remove later)
		print("DICE ROLLED: ", Global.rolling_dice_list)
		print("DICE SAVED: ", Global.saved_dice_list)


func _save_button_pressed():
	if !any_dice_rolling and !Global.first_round_roll:
		save_dice()

func save_dice():
	# Dice to be saved
	var index: int = 0
	
	if !dice_saved and !Global.current_lot_scored:
		dice_saved = true
		position.y += 40
		dice_in_play -= 1
	
		for dice in Global.rolling_dice_list:
			if dice == number_rolled:
				Global.saved_dice_list.append(number_rolled)
				Global.rolling_dice_list.remove_at(index)
				break
			index += 1
	# Dice to be unsaved
	elif dice_saved and Global.rerolls > 0:
		dice_saved = false
		position.y -= 40
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
