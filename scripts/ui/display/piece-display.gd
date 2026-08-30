extends Node2D

class_name PieceDisplay

#signal clicked(piece: PieceDisplay)

@export var piece: PieceInfo

@onready var piece_area: Area2D = %PieceArea
@onready var piece_sprite: Sprite2D = %PieceSprite
@onready var piece_collision_shape: CollisionShape2D = %PieceCollisionShape
@onready var hint_display: Control = %HintDisplay
@onready var piece_name_label: Label = %PieceName
@onready var piece_description_label: RichTextLabel = %PieceDescription

@onready var score_popup: Node2D = %ScorePopup
@onready var score_popup_label: Label = %ScorePopupLabel
var popup_tween: Tween


func _ready() -> void:
	if piece == null:
		piece = PieceInfo.new()
	
	piece_sprite.texture = piece.texture
	hint_display.visible = false
	
	score_popup.modulate.a = 0.0
	
	PieceManager.register_display(self)
	PieceManager._update_piece_labels.connect(_on_update_piece_labels)

func _exit_tree() -> void:
	pass
	# same unregister when selling or deletion

func setup(new_piece: PieceInfo) -> void:
	piece = new_piece
	piece_sprite.texture = piece.texture
	_on_update_piece_labels()

func _on_update_piece_labels():
	piece_name_label.text = piece.piece_name
	piece_description_label.text = piece.piece_description


func show_score(add_value: int, mult_value: int, text_color: Color) -> Tween:
	if add_value == 0 and mult_value == 0:
		return
	
	var text: String = ""
	
	if add_value != 0:
		text = "+" + str(add_value)
	elif mult_value != 0:
		text = "+" + str(mult_value)
	
	score_popup_label.text = text
	score_popup_label.add_theme_color_override("font_color", text_color)
	
	return play_popup()

func play_popup() -> Tween:
	if popup_tween and popup_tween.is_running():
		popup_tween.kill()
	
	score_popup.global_position = global_position + Vector2(0, -40)
	score_popup.scale = Vector2(0.8, 0.8)
	score_popup.modulate.a = 1.0
	
	var punch: Tween = create_tween()
	punch.tween_property(piece_sprite, "scale", Vector2(1.15, 1.15), 0.1)
	punch.tween_property(piece_sprite, "scale", Vector2.ONE, 0.15)
	
	popup_tween = create_tween()
	popup_tween.tween_interval(0.25)
	popup_tween.tween_property(score_popup, "global_position:x", score_popup.global_position.x - 400, 0.35)\
		.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	popup_tween.parallel().tween_property(score_popup, "modulate:a", 0.0, 0.35)
	
	return popup_tween


func _on_mouse_entered() -> void:
	hint_display.visible = true

func _on_mouse_exited() -> void:
	hint_display.visible = false
