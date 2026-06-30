extends Control

signal _buy_piece()

@onready var piece_button: Button = %PieceButton
@onready var skip_button: Button = %SkipButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	skip_button.pressed.connect(_shop_skip_button_pressed)

# Upgrade category button

# Modify dice button

func _shop_skip_button_pressed() -> void:
	GameData._reset_round.emit()
