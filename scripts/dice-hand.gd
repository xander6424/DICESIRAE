extends Node2D

class_name DiceHand

@export var dice_scene: PackedScene

var dice_nodes: Dictionary = {} # Stores actual visible nodes associated with dice info instances


func _ready() -> void:
	DiceData.dice_hand_slots.resize(DiceData.HAND_POSITIONS.size())
	DiceData.dice_saved_slots.resize(DiceData.SAVED_POSITIONS.size())
	
	DiceManager._on_hand_drawn.connect(_on_hand_drawn)
	DiceManager._on_saved_discarded.connect(_on_saved_discarded)
	DiceManager._force_unsave.connect(_on_force_unsave)

func _on_hand_drawn() -> void:
	# Find the first empty dice slot to display drawn dice
	for dice in DiceManager.rolling_dice_list:
		if !dice_nodes.has(dice):
			var empty_index: int = DiceData.dice_hand_slots.find(null)
			spawn_dice(dice, empty_index)
	
	print("HAND DRAWN")

func _on_saved_discarded(discarded_dice_list: Array[DiceInfo]) -> void:
	for dice in discarded_dice_list:
		if dice_nodes.has(dice):
			# Removes the discarded dice node
			var node: DiceDisplay = dice_nodes[dice]
			node.queue_free()
			dice_nodes.erase(dice)
			
			# Frees up space in the saved dice slot(s)
			var used_index: int = DiceData.dice_saved_slots.find(dice)
			DiceData.dice_saved_slots[used_index] = null
	
	print("HAND DISCARDED")

func _on_force_unsave(dice: DiceInfo):
	if dice_nodes.has(dice):
		dice_nodes[dice].visually_unsave()


func spawn_dice(dice: DiceInfo, open_index: int) -> void:
	# Create a node, instantiate its values, and place it
	var node: DiceDisplay = dice_scene.instantiate()
	add_child(node) # Add to hand container
	node.position = DiceData.HAND_POSITIONS[open_index]
	node.setup(dice)
	
	# Fill the once empty dice slot
	dice_nodes[dice] = node
	DiceData.dice_hand_slots[open_index] = dice
