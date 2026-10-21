extends Node2D

class_name DiceHand

@export var dice_scene: PackedScene

var dice_nodes: Dictionary = {} # Stores actual visible nodes associated with dice info instances


func _ready() -> void:
	DiceData.dice_hand_slots.resize(DiceData.HAND_POSITIONS.size())
	DiceData.dice_saved_slots.resize(DiceData.SAVED_POSITIONS.size())
	
	DiceManager._on_hand_drawn.connect(_on_hand_drawn)
	DiceManager._on_dice_discarded.connect(_on_dice_discarded)
	DiceManager._force_unsave.connect(_on_force_unsave)


func _on_hand_drawn() -> void:
	# Find the first empty dice slot to display drawn dice
	for dice in DiceManager.rolling_dice_list:
		if !dice_nodes.has(dice):
			var empty_index: int = DiceData.dice_hand_slots.find(null)
			
			await spawn_dice(dice, empty_index)
	
	await get_tree().process_frame
	DiceManager._draw_animation_done.emit()
	print("HAND DRAWN")

func spawn_dice(dice: DiceInfo, open_index: int) -> void:
	# Create a node, instantiate its values, and place it
	var open_slot = DiceData.HAND_POSITIONS[open_index]
	var node: DiceDisplay = dice_scene.instantiate()
	add_child(node)
	node.setup(dice)
	node.position = DiceData.DRAW_PILE_POSITION
	node.modulate.a = 0.0
	
	await play_draw(node, open_slot)
	node.position = open_slot
	node.freeze = false
	
	# Fill the once empty dice slot
	dice_nodes[dice] = node
	DiceData.dice_hand_slots[open_index] = dice

func play_draw(node: DiceDisplay, open_slot: Vector2) -> void:
	var draw_tween = create_tween()
	draw_tween.set_parallel()
	draw_tween.tween_property(node, "position", open_slot, 0.3).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUART)
	draw_tween.tween_property(node, "modulate:a", 1.0, 0.15).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_EXPO)
	await draw_tween.finished


func _on_dice_discarded(discarded_dice_list: Array[DiceInfo], dice_slots: Array) -> void:
	for dice in discarded_dice_list:
		if dice_nodes.has(dice):
			var node: DiceDisplay = dice_nodes[dice]
			
			await play_discard(node)
			
			# Removes the discarded dice node
			node.queue_free()
			dice_nodes.erase(dice)
		
		# Frees up space in the saved dice slot(s)
		for slots in [DiceData.dice_hand_slots, DiceData.dice_saved_slots]:
			var used_index: int = slots.find(dice)
			if used_index != -1:
				slots[used_index] = null
	
	await get_tree().process_frame
	DiceManager._discard_animation_done.emit()
	print("HAND DISCARDED")

func play_discard(node: DiceDisplay) -> void:
	var discard_tween = create_tween()
	discard_tween.set_parallel()
	discard_tween.tween_property(node, "position", DiceData.DISCARD_PILE_POSITION, 0.3).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUART)
	discard_tween.tween_property(node, "modulate:a", 0.0, 0.3).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_EXPO)
	await discard_tween.finished

func _on_force_unsave(dice: DiceInfo):
	if dice_nodes.has(dice):
		await dice_nodes[dice].visually_unsave()
	
	await get_tree().process_frame
	DiceManager._discard_animation_done.emit()
	print("FORCE SAVED ", dice.faces[dice.current_face_index].face_value)
