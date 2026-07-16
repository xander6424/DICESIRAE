extends Node2D

class_name PieceHand

@export var piece_scene: PackedScene

var piece_nodes: Dictionary = {} # Stores actual visible nodes associated with piece info instance


func _ready() -> void:
	PieceData.piece_hand_slots.resize(PieceData.PIECE_POSITIONS.size())
	
	# Connect signals here

func _on_piece_purchased(piece: PieceInfo):
	var empty_index: int = PieceData.piece_hand_slots.find(null)
	spawn_piece(piece, empty_index)

func spawn_piece(piece: PieceInfo, open_index: int) -> void:
	# Create a node, instantiate its values, and place it
	var node: PieceDisplay = piece_scene.instantiate()
	add_child(node) # Add to hand container
	node.position = PieceData.PIECE_POSITIONS[open_index]
	node.setup(piece)
	
	# Fill the once empty dice slot
	piece_nodes[piece] = node
	PieceData.piece_hand_slots[open_index] = piece
