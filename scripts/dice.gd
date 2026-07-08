extends RigidBody2D

class_name DiceNode


@onready var face_sprite: Sprite2D = %FaceSprite
@onready var roll_button = get_parent().get_parent().get_node("RollButton") # THIS SUCKS
@onready var save_button: TextureButton = %SaveButton

@export var dice: DiceInfo
@export var face_textures: Array[Texture2D] = []

static var dice_currently_rolling: int = 0

var rolling: bool = false
var dice_saved: bool = false


func _ready() -> void:
	if dice == null:
		dice = DiceInfo.new()
	
	display_face(dice.get_current_face())
	# CHANGE COLOR HERE TOO??
	
	roll_button.pressed.connect(roll_button_pressed)
	save_button.pressed.connect(_save_button_pressed)

func setup(new_dice: DiceInfo):
	dice = new_dice
	dice_saved = false
	rolling = false
	
	# faces display
	# color change


func roll_button_pressed():
	if !rolling and !dice_saved:
		GameData.first_round_roll = false
		roll_button.disabled = true
		roll_dice()

func roll_dice():
	rolling = true
	dice_currently_rolling += 1
	
	# ADD PHYSICS HERE
	
	var duration: float = GameData.ROLL_DURATION
	var previous_index: int = dice.current_face_index
	
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
	# Dice to be saved
	if !dice_saved:
		dice_saved = true
		position.y += 40
		DiceManager.save_dice(dice)
	# Dice to be unsaved
	elif dice_saved:
		dice_saved = false
		position.y -= 40
		DiceManager.unsave_dice(dice)
	
	if GameData.rerolls > 0:
		roll_button.disabled = DiceManager.rolling_dice_list.is_empty()

func display_face(face: DiceFace) -> void:
	var index: int = face.face_value - 1
	face_sprite.texture = face_textures[index]
	# CHANGE COLOR HERE TOO
