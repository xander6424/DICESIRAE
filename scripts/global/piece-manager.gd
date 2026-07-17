extends Node

# Emit signals from here to the display nodes to animate
signal _update_piece_labels()

var active_piece_list: Array[PieceInfo] = []


func reset_round() -> void:
	pass

func round_started() -> void:
	for piece in active_piece_list:
		piece.round_started()
		_update_piece_labels.emit()

func round_ended() -> void:
	pass

func dice_scored(dice: DiceInfo) -> void:
	for piece in active_piece_list:
		var score_values: Array[int] = piece.dice_scored(dice)
		
		print(piece.piece_name, " ADD +", score_values[0])
		GameData.total_add_score += score_values[0]
		
		print(piece.piece_name, " MULT +", score_values[1])
		GameData.total_mult_score += score_values[1]
		
		#current_category.mult_score *= score_values[2]

func pieces_scored() -> void:
	for piece in active_piece_list:
		var score_values: Array[int] = piece.piece_scored()
		
		print(piece.piece_name, " ADD +", score_values[0])
		GameData.total_add_score += score_values[0]
		
		print(piece.piece_name, " MULT +", score_values[1])
		GameData.total_mult_score += score_values[1]
		
		#current_category.mult_score *= score_values[2]

func reset_piece_values() -> void:
	for piece in active_piece_list:
		piece.reset_values()
