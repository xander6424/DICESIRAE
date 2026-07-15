extends RigidBody2D
 
class_name DiceDisplay
 
@onready var face_sprite: Sprite2D = %FaceSprite
@onready var roll_button = get_parent().get_parent().get_node("RollButton") # THIS SUCKS
@onready var save_button: TextureButton = %SaveButton
 
@export var dice: DiceInfo
@export var face_textures: Array[Texture2D] = []
 
# Physics variables
@export var min_impulse_strength: float = 300.0
@export var max_impulse_strength: float = 550.0
@export var max_torque_impulse: float = 1000.0
 
static var dice_currently_rolling: int = 0
var rolling: bool = false
var dice_saved: bool = false
 
 
func _ready() -> void:
	# Backup to create a dice class instance for the node
	if dice == null:
		dice = DiceInfo.new()
	
	# Display a random face upon being drawn
	display_face(dice.faces[randi() % dice.dice_size])
	# CHANGE COLOR HERE TOO?? (Or possibly in the display face function)
	
	# Basic table friction.
	linear_damp = 1.2
	angular_damp = 1.2
	
	roll_button.pressed.connect(roll_button_pressed)
	save_button.pressed.connect(_save_button_pressed)
 
func setup(new_dice: DiceInfo):
	dice = new_dice
	dice_saved = false
	rolling = false
	
	# faces display?
	# color change?
 
 
func roll_button_pressed():
	if !rolling and !dice_saved:
		GameData.first_round_roll = false
		roll_button.disabled = true
		roll_dice()
 
func roll_dice():
	rolling = true
	dice_currently_rolling += 1
	
	var duration: float = GameData.ROLL_DURATION
	var previous_index: int = dice.current_face_index
	
	# PHYSICS
	var angle: float = randf_range(0.0, TAU)
	var direction: Vector2 = Vector2.from_angle(angle)
	var strength: float = randf_range(min_impulse_strength, max_impulse_strength)
	
	apply_central_impulse(direction * strength)
	apply_torque_impulse(randf_range(-max_torque_impulse, max_torque_impulse))
	
	# Start the rolling animation
	while duration > 0.0:
		var current_index: int = previous_index
		
		# Prevent duplicate faces from being shown in a row
		while current_index == previous_index:
			current_index = randi() % dice.faces.size()
		previous_index = current_index
		display_face(dice.faces[previous_index])
		
		await get_tree().create_timer(0.1).timeout
		duration -= 0.1
	
	# Finally end by generating a roll
	var result: DiceFace = dice.roll()
	display_face(result)
	
	rolling = false
	linear_velocity = Vector2.ZERO
	angular_velocity = 0.0
	dice_currently_rolling -= 1
	
	# Doesn't count a roll until all dice are scored
	if dice_currently_rolling == 0:
		if GameData.rerolls > 0:
			roll_button.disabled = false
		
		GameData.rerolls -= 1 # change this?
		DiceManager._hand_rolling_done.emit()
 
 
func _save_button_pressed():
	if !rolling and !GameData.first_round_roll:
		save_dice()
 
func save_dice():
	# Dice node to be SAVED
	if !dice_saved:
		dice_saved = true
		swap_slots(DiceData.dice_saved_slots, DiceData.dice_hand_slots, DiceData.SAVED_POSITIONS)
		DiceManager.save_dice(dice)
	# Dice node to be UNSAVED
	elif dice_saved:
		dice_saved = false
		swap_slots(DiceData.dice_hand_slots, DiceData.dice_saved_slots, DiceData.HAND_POSITIONS)
		DiceManager.unsave_dice(dice)
	
	# Disable roll button if all dice are saved
	if GameData.rerolls > 0:
		roll_button.disabled = DiceManager.rolling_dice_list.is_empty()
 
# Force handles unsaving dice visually to avoid touching data
func visually_unsave():
	if dice_saved:
		dice_saved = false
		swap_slots(DiceData.dice_hand_slots, DiceData.dice_saved_slots, DiceData.HAND_POSITIONS)
 
# Swaps dice between chosen slots and positions them
func swap_slots(new_slots: Array, old_slots: Array, positions: Array[Vector2]) -> void:
	var empty_index: int = new_slots.find(null)
	var old_index: int = old_slots.find(dice)
	new_slots[empty_index] = dice
	old_slots[old_index] = null
	position = positions[empty_index]
 
 
func display_face(face: DiceFace) -> void:
	var index: int = face.face_value - 1
	face_sprite.texture = face_textures[index]
	# CHANGE/DISPLAY COLOR HERE TOO
