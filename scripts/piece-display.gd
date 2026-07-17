extends Node2D

class_name PieceDisplay

#signal clicked(piece: PieceDisplay)

@export var piece: PieceInfo

@onready var piece_area: Area2D = %PieceArea
@onready var piece_sprite: Sprite2D = %PieceSprite
@onready var piece_collision_shape: CollisionShape2D = %PieceCollisionShape
@onready var hint_display: Control = %HintDisplay
@onready var piece_name_label: Label = %PieceName
@onready var piece_description_label: Label = %PieceDescription


func _ready() -> void:
	if piece == null:
		piece = PieceInfo.new()
	
	piece_sprite.texture = piece.texture
	hint_display.visible = false

func setup(new_piece: PieceInfo) -> void:
	piece = new_piece
	piece_sprite.texture = piece.texture
	piece_name_label.text = piece.piece_name
	piece_description_label.text = piece.piece_description


func _on_mouse_entered() -> void:
	hint_display.visible = true

func _on_mouse_exited() -> void:
	hint_display.visible = false
