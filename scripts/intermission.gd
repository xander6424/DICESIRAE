extends Control

signal _on_update_round_status()

@onready var background: ColorRect = %Background
@onready var shop_button: Button = %ShopButton
@onready var shop: Control = %Shop
@onready var intermission: Control = %Intermission

@onready var round_results_title: Label = %RoundResults
@onready var cleared_label: Label = %Cleared
@onready var spare_lots_label: Label = %SpareLots
@onready var overkill_bonus_label: Label = %OverkillBonus
@onready var interest_label: Label = %Interest

const CLEARED_MONEY: int = 2
const OVERKILL_MONEY: int = 1
var money_earned: int = 0

func _ready() -> void:
	shop_button.pressed.connect(shop_button_pressed)
	reset_intermission()

func reset_intermission() -> void:
	cleared_label.visible = false
	spare_lots_label.visible = false
	overkill_bonus_label.visible = false
	interest_label.visible = false


func _on_update_intermission() -> void:
	money_earned = 0
	round_results_title.text = "ROUND " + str(GameData.round_number) + " RESULTS"
	
	# Cleared round bonus
	if GameData.round_won:
		cleared_label.text = "Cleared . . . . . . . . . . . . . $" + str(CLEARED_MONEY)
		cleared_label.visible = true
		money_earned += CLEARED_MONEY
	# Spare lots for cash
	if GameData.lots > 0:
		spare_lots_label.text = "Spare Lots . . . . . . . . . . . $" + str(GameData.lots)
		spare_lots_label.visible = true
		money_earned += GameData.lots
	# Overkill bonus (cleared in one lot)
	if GameData.lots >= (GameData.STARTING_LOTS + GameData.bonus_lots) - 1:
		overkill_bonus_label.text = "Overkill Bonus  . . . . . . . . . $" + str(OVERKILL_MONEY)
		overkill_bonus_label.visible = true
		money_earned += OVERKILL_MONEY
	# Interest
	if GameData.money >= 5:
		@warning_ignore("integer_division") # No floor division available in GDScript
		var interest: int = GameData.money / 5
		interest_label.text = "Interest (per $5) . . . . . . . $" + str(interest)
		interest_label.visible = true
		money_earned += interest
	
	shop_button.text = "COLLECT $" + str(money_earned)

# Move to shop scene and add new money
func shop_button_pressed():
	GameData.money += money_earned
	
	intermission.visible = false
	background.color = Color(0.149, 0.122, 0.235, 1.0)
	shop.visible = true
	reset_intermission()
	
	_on_update_round_status.emit()
