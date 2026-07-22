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

@onready var score_popup: Node2D = %ScorePopup
@onready var score_popup_label: Label = %ScorePopupLabel

var popup_base_position: Vector2
var popup_tween: Tween


func _ready() -> void:
	if piece == null:
		piece = PieceInfo.new()
	
	piece_sprite.texture = piece.texture
	hint_display.visible = false
	
	popup_base_position = score_popup.position
	score_popup.modulate.a = 0.0
	
	PieceManager._update_piece_labels.connect(_on_update_piece_labels)

func setup(new_piece: PieceInfo) -> void:
	piece = new_piece
	piece_sprite.texture = piece.texture
	_on_update_piece_labels()

func _on_update_piece_labels():
	piece_name_label.text = piece.piece_name
	piece_description_label.text = piece.piece_description


func show_score(add_value: int, mult_value: int) -> void:
	if add_value == 0 and mult_value == 0:
		return
	
	var text: String = ""
	
	if add_value != 0:
		text = "+" + str(add_value)
	elif mult_value != 0:
		text = "+" + str(mult_value)
	
	play_popup(text)
	
	

func play_popup(text: String) -> void:
	if popup_tween and popup_tween.is_running():
		popup_tween.kill()
	
	score_popup_label.text = text
	score_popup.position = popup_base_position
	score_popup.scale = Vector2(0.8, 0.8)
	score_popup.modulate.a = 1.0
	
	popup_tween = create_tween()
	popup_tween.set_parallel(true)
	popup_tween.tween_property(score_popup, "position:y", popup_base_position.y - 40, 0.5)\
		.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	popup_tween.tween_property(score_popup, "scale", Vector2.ONE, 0.15)\
		.set_trans(Tween.TRANS_BACK)
	popup_tween.chain().tween_property(score_popup, "modulate:a", 0.0, 0.25).set_delay(0.15)


func _on_mouse_entered() -> void:
	hint_display.visible = true

func _on_mouse_exited() -> void:
	hint_display.visible = false
