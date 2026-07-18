extends Control

@onready var background: ColorRect = %Background
@onready var shop_button: Button = %ShopButton
@onready var shop: Control = %Shop
@onready var intermission: Control = %Intermission


func _ready() -> void:
	shop_button.pressed.connect(shop_button_pressed)

func shop_button_pressed():
	intermission.visible = false
	background.color = Color(0.149, 0.122, 0.235, 1.0)
	shop.visible = true
