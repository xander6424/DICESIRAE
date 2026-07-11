extends Control

#signal _buy_piece()
signal _on_update_round_status()

@onready var piece_button: Button = %PieceButton
@onready var skip_button: Button = %SkipButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	piece_button.pressed.connect(piece_button_pressed)
	skip_button.pressed.connect(_shop_skip_button_pressed)

# Random piece button
func piece_button_pressed() -> void:
	if GameData.money >= 3:
		var random_piece: PieceInfo = PieceData.FULL_PIECE_LIST.pick_random()
		PieceData.active_piece_list.append(random_piece)
		random_piece.using = true
		print("PURCHASED: ", random_piece.piece_name)
		
		GameData.money -= 3
		
		_on_update_round_status.emit()
	else:
		print("NOT ENOUGH MONEY")

# Upgrade category button

# Modify dice button

func _shop_skip_button_pressed() -> void:
	GameData._reset_round.emit()
