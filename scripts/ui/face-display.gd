extends Control

signal _face_modification_selected(value)
signal _type_modification_selected()

@onready var shop: Control = %Shop

class FaceDisplay:
	var face_sprite: Sprite2D
	var face_button: TextureButton
	var index: int
	# color
	# value?
	
	func _init(_sprite: Sprite2D, _button: TextureButton):
		face_sprite = _sprite
		face_button = _button

const DEFAULT_TEXTURE: Texture = preload("uid://cogrse307h7pm")

# Big dice face displays
var face1: FaceDisplay
var face2: FaceDisplay
var face3: FaceDisplay
var face4: FaceDisplay
var face5: FaceDisplay
var face6: FaceDisplay
var face_display_list: Array[FaceDisplay] = [face1, face2, face3, face4, face5, face6]

# Modifying value buttons
var button1: Button
var button2: Button
var button3: Button
var button4: Button
var button5: Button
var button6: Button
var button_type: Button
@onready var button_return: Button = %ButtonReturn
var value_button_list: Array[Button] = [button1, button2, button3, button4, button5, button6, button_type]

var current_face_index = null

func _ready() -> void:
	var face_nodes: Array[Node2D] = [%Face1, %Face2, %Face3, %Face4, %Face5, %Face6]
	var button_nodes: Array[Button] = [%Button1, %Button2, %Button3, %Button4, %Button5, %Button6, %ButtonType]
	var display_index: int = 0
	var button_index: int = 0
	
	for node in face_nodes:
		var sprite: Sprite2D = node.get_child(0)
		var button: TextureButton = node.get_child(1)
		face_display_list[display_index] = FaceDisplay.new(sprite, button)
		display_index += 1
	
	for button in button_nodes:
		value_button_list[button_index] = button
		button_index += 1

func display_dice_faces(dice: DiceInfo, dice_display: DiceDisplay) -> void:
	if dice != null:
		var texture_index: int = 0
		
		for display in face_display_list:
			display.index = texture_index
			display.face_sprite.texture = dice.faces[texture_index].face_texture
			display.face_sprite.modulate = dice.dice_color
			texture_index += 1
		
		print("[", 
			dice.faces[0].face_value, ", ",
			dice.faces[1].face_value, ", ",
			dice.faces[2].face_value, ", ",
			dice.faces[3].face_value, ", ",
			dice.faces[4].face_value, ", ",
			dice.faces[5].face_value, "]"
		)
	else:
		for display in face_display_list:
			display.face_sprite.texture = DEFAULT_TEXTURE
			display.face_sprite.modulate = Color.WHITE



# face selected
func _on_face_toggled(toggled_on: bool) -> void:
	if toggled_on:
		for face in face_display_list:
			if face.face_button.button_pressed:
				print("FACE INDEX ", face.index)
				current_face_index = face.index
	else:
		current_face_index = null

func _on_button_pressed() -> void:
	#var selection: Button = null
	var value: int = 0
	
	for button in value_button_list:
		if button.button_pressed:
			if button != %ButtonType:
				value = int(button.text)
				_face_modification_selected.emit(value, current_face_index)
			else:
				_type_modification_selected.emit()


func _on_return_button_pressed() -> void:
	await DiceManager.round_ended() # called solely for discarding dice
	GameData.intermission = false
	self.visible = false
	shop.visible = true
	shop.current_dice = null
	shop.current_display = null
	current_face_index = null
	display_dice_faces(shop.current_dice, shop.current_display)
