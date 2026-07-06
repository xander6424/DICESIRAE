extends Node2D

class_name DiceHand

@export var dice_scene: PackedScene
@export var spacing: float = 90.0
@export var row_y: float = 0.0

var dice_nodes: Dictionary = {}

func _ready() -> void:
	DiceManager._on_hand_drawn.connect(_on_hand_drawn)

func _on_hand_drawn() -> void:
	for node in dice_nodes.values():
		node.queue_free()
	dice_nodes.clear()
	
	var positions: Array[Vector2] = compute_dice_positions(DiceManager.rolling_dice_list.size())
	
	for i in range(DiceManager.rolling_dice_list.size()):
		spawn_dice(DiceManager.rolling_dice_list[i], positions[i])
	
	print("HAND DRAWN")

func compute_dice_positions(count: int) -> Array[Vector2]:
	var positions: Array[Vector2] = []
	var total_width: float = spacing * float(count - 1)
	var start_x: float = -total_width / 2.0
	
	for i in range(count):
		positions.append(Vector2(start_x + float(i) * spacing, row_y))
	
	return positions

func spawn_dice(dice: DiceInfo, starting_position) -> void:
	var node: DiceNode = dice_scene.instantiate()
	add_child(node)
	node.position = starting_position
	node.setup(dice)
	dice_nodes[dice] = node
