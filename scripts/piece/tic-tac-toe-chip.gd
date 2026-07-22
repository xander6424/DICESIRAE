extends PieceInfo

class_name TicTacToeChip

# ABILITY:
# Add +9 to the mult score if the played hand contains 3 or more dice.
	# No secret synergies

const MULT_SCORE: int = 9


func piece_scored() -> Array[int]:
	if DiceManager.scoring_dice_list.size() >= 3:
		return [0, MULT_SCORE]
	
	return [0, 0]
