extends PieceInfo

class_name Pawn

var times_scored: int = 2

func dice_scored():
	if times_scored > 0:
		times_scored -= 1
		return 10
	else:
		return 0
	
	# Add +10 to addition score for first 3 dice scored.
	# Enchances to a random chess piece after 3 rounds.
	# No secret synergies.
