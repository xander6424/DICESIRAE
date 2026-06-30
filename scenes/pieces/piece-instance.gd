extends Area2D

@export var piece_data: PieceInstance:
	set(value):
		piece_data = value
		if is_inside_tree():
			update_visuals()

@onready var piece_sprite: Sprite2D = %PieceSprite

func _ready() -> void:
	update_visuals()

func update_visuals() -> void:
	if not piece_data:
		return
	
	if "texture" in piece_data and piece_data.texture:
		piece_sprite.texture = piece_data.texture

func _purchase_piece() -> void:
	GameData.active_piece_list.append(piece_data)
