extends RigidBody2D

signal reset()
signal roll_done(index: int)
signal saved_pressed(number_rolled: int, saved: bool)

@onready var faces: Node2D = %Faces
@onready var roll_button: TextureButton = %RollButton
@onready var save_button: Button = %SaveButton

var number_rolled = 0
var current_index = 0
var new_index = 0
var rolling = false
var saved = false

func _ready() -> void:
	for face in faces.get_children():
		face.hide()
	
	# Select a starting face at random
	var starting_index = faces.get_children().pick_random().get_index()
	faces.get_child(starting_index).show()
	
	roll_button.pressed.connect(roll_button_pressed)
	save_button.pressed.connect(_save_button_pressed)

func _process(delta: float) -> void:
	if Global.rerolls <= 0 and save_button.disabled == false:
		_save_button_pressed()
		save_button.disabled = true


func roll_button_pressed():
	if !rolling and !saved:
		roll_button.disabled = true
		reset.emit()
		_roll_dice()

func _roll_dice():
	var duration = 0.8
	rolling = true
	
	while duration > 0:
		# Prevent duplicate faces from being shown in a row
		while current_index == new_index:
			new_index = faces.get_children().pick_random().get_index()
		
		faces.get_child(current_index).hide()
		faces.get_child(new_index).show()
		
		await get_tree().create_timer(0.1).timeout
		
		current_index = new_index
		duration -= 0.1
	
	number_rolled = current_index + 1
	rolling = false
	
	# Return basic D6 dice roll
	roll_done.emit(number_rolled)


func _save_button_pressed():
	if !rolling:
		if !saved:
			saved = true
			position.y += 25
		elif saved and Global.rerolls > 0:
			saved = false
			position.y -= 25
		
		saved_pressed.emit(number_rolled, saved)
