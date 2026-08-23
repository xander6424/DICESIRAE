extends Control

@onready var game_over: Control = %GameOver
@onready var exit_button: Button = %ExitButton


func _ready() -> void:
	game_over.visible = false
	exit_button.pressed.connect(exit_button_pressed)

# Eventually add a button to play again and reset the game
# func restart_button_pressed() -> void:
	# pass

func exit_button_pressed() -> void:
	get_tree().quit()
