extends Control

#signal _buy_piece()

@onready var piece_button: Button = %PieceButton
@onready var skip_button: Button = %SkipButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	piece_button.pressed.connect(piece_button_pressed)
	skip_button.pressed.connect(_shop_skip_button_pressed)

# Random piece button
func piece_button_pressed() -> void:
	if GameData.money >= 3:
		var random_piece: PieceData = GameData.FULL_PIECE_LIST.pick_random()
		GameData.active_piece_list.append(random_piece)
		print(GameData.active_piece_list)
		
		# Test to activate the piece
		GameData.active_piece_list[0].dice_scored()
		
		GameData.money -= 3
	else:
		print("NOT ENOUGH MONEY")

# Upgrade category button

# Modify dice button

func _shop_skip_button_pressed() -> void:
	GameData._reset_round.emit()
