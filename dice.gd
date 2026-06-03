extends RigidBody2D

# change???
signal roll_done(index: int)

@onready var faces: Node2D = %Faces

var rolling = false
var current_index = 0
var new_index = 0

# Runs when node(s) enter the scene tree
func _ready() -> void:
	for face in faces.get_children():
		face.hide()
	
	# Select a starting face at random
	var starting_index = faces.get_children().pick_random().get_index()
	faces.get_child(starting_index).show()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Roll") and !rolling:
		_roll_dice()

func _roll_dice():
	var duration = 0.8
	rolling = true
	
	while duration > 0:
		# Prevent duplicate faces from being shown
		while current_index == new_index:
			new_index = faces.get_children().pick_random().get_index()
		
		faces.get_child(current_index).hide()
		faces.get_child(new_index).show()
		
		await get_tree().create_timer(0.1).timeout
		
		current_index = new_index
		duration -= 0.1
	
	rolling = false
	
	roll_done.emit(current_index + 1)
