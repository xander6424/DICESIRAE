extends Area2D

class_name PieceDisplay

#signal clicked(piece: PieceDisplay)

@export var piece: PieceInfo

@onready var piece_sprite: Sprite2D = %PieceSprite
@onready var piece_collision_shape: CollisionShape2D = %PieceCollisionShape



func _ready() -> void:
	if piece == null:
		piece = PieceInfo.new()
	
	piece_sprite.texture = piece.texture

func setup(new_piece: PieceInfo) -> void:
	piece = new_piece
	piece_sprite.texture = piece.texture
