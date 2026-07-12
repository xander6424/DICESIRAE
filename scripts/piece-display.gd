extends Area2D

class_name PieceDisplay

#signal clicked(piece: PieceDisplay)

@export var piece_data: PieceInfo:
	set(value):
		piece_data = value
		if is_inside_tree():
			update_visuals()

@onready var piece_sprite: Sprite2D = %PieceSprite
@onready var piece_collision_shape: CollisionShape2D = %PieceCollisionShape


func _ready() -> void:
	#input_event.connect(_on_input_event)
	update_visuals()

func update_visuals() -> void:
	if not piece_data:
		return
	
	if "texture" in piece_data and piece_data.texture:
		piece_sprite.texture = piece_data.texture

#func _on_input_event(_viewport, event: InputEvent, _shape_idx) -> void:
	#if event is InputEventMouseButton and event.pressed:
		#clicked.emit(self)
