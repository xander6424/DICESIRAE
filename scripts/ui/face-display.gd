extends Control

class FaceDisplay:
	var face_sprite: Sprite2D
	var face_button: TextureButton
	# color
	# value?
	
	func _init(_sprite: Sprite2D, _button: TextureButton):
		face_sprite = _sprite
		face_button = _button

const DEFAULT_TEXTURE: Texture = preload("uid://cogrse307h7pm")
var face1: FaceDisplay
var face2: FaceDisplay
var face3: FaceDisplay
var face4: FaceDisplay
var face5: FaceDisplay
var face6: FaceDisplay
var face_display_list: Array[FaceDisplay] = [face1, face2, face3, face4, face5, face6]

func _ready() -> void:
	var face_nodes: Array[Node2D] = [%Face1, %Face2, %Face3, %Face4, %Face5, %Face6]
	var display_index: int = 0
	
	for node in face_nodes:
		var sprite: Sprite2D = node.get_child(0)
		var button: TextureButton = node.get_child(1)
		face_display_list[display_index] = FaceDisplay.new(sprite, button)
		display_index += 1

func display_dice_faces(dice: DiceInfo, dice_display: DiceDisplay) -> void:
	if dice != null:
		var texture_index: int = 0
		
		for display in face_display_list:
			display.face_sprite.texture = dice_display.face_textures[texture_index]
			texture_index += 1
	else:
		for display in face_display_list:
			display.face_sprite.texture = DEFAULT_TEXTURE
	
	#print("DISPLAY FACES FOR: ", dice)
