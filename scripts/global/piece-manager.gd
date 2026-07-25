extends Node

# Emit signals from here to the display nodes to animate
signal _update_piece_labels()

const MAX_PIECES_SIZE: int = 5
var active_piece_list: Array[PieceInfo] = []
var active_display_list: Array[PieceDisplay] = []


func register_display(display: PieceDisplay) -> void:
	active_display_list.append(display)

func reset_round() -> void:
	pass

func round_started() -> void:
	for piece in active_piece_list:
		piece.round_started()
		_update_piece_labels.emit()

func round_ended() -> void:
	pass

func dice_scored(dice: DiceInfo) -> void:
	for display in active_display_list:
		var piece: PieceInfo = display.piece
		var score_values: Array[int] = piece.dice_scored(dice)
		if score_values[0] == 0 and score_values[1] == 0:
			continue
		
		print(piece.piece_name, " ADD +", score_values[0])
		GameData.total_add_score += score_values[0]
		print(piece.piece_name, " MULT +", score_values[1])
		GameData.total_mult_score += score_values[1]
		#current_category.mult_score *= score_values[2]
		
		_update_piece_labels.emit() # Change these signals?
		
		await display.show_score(score_values[0], score_values[1])
		# SIGNAL TO UPDATE VISUAL SCORE
		await get_tree().create_timer(0.35).timeout


func pieces_scored() -> void:
	for display in active_display_list:
		var piece: PieceInfo = display.piece
		var score_values: Array[int] = piece.piece_scored()
		if score_values[0] == 0 and score_values[1] == 0:
			continue
		
		print(piece.piece_name, " ADD +", score_values[0])
		GameData.total_add_score += score_values[0]
		print(piece.piece_name, " MULT +", score_values[1])
		GameData.total_mult_score += score_values[1]
		#current_category.mult_score *= score_values[2]
		
		await display.show_score(score_values[0], score_values[1])
		# SIGNAL TO UPDATE VISUAL SCORE
		await get_tree().create_timer(0.5).timeout

func reset_piece_values() -> void:
	for piece in active_piece_list:
		piece.reset_values()
