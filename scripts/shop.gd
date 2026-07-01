extends Control

signal _buy_piece()

@onready var piece_button: Button = %PieceButton
@onready var skip_button: Button = %SkipButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	piece_button.pressed.connect(piece_button_pressed)
	skip_button.pressed.connect(_shop_skip_button_pressed)

# Random piece button
func piece_button_pressed() -> void:
	print("CLICKED")

# Upgrade category button

# Modify dice button

func _shop_skip_button_pressed() -> void:
	GameData._reset_round.emit()
