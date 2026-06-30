extends Resource

class_name PieceInstance

@export var piece_id: String = "" # change to enum?
@export var piece_name: String = ""
@export var piece_description: String = ""
@export var texture: Texture2D

@export var sell_value: int


func piece_scored():
	pass

func dice_scored():
	pass

func round_started():
	pass

func round_ended():
	pass
