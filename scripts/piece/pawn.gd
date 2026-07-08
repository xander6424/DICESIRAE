extends PieceInfo

class_name Pawn

# ABILITY:
# Add +10 to addition score for first 3 dice scored.
	# Enchances to a random chess piece after 3 rounds.
		# No secret synergies.

const MAX_SCORING: int = 3
const MAX_ROUNDS: int = 3
var times_scored: int = 0
var rounds_passed: int = 0

func dice_scored():
	if times_scored < MAX_SCORING:
		times_scored += 1
		return 10
	else:
		return 0

# check if 3 rounds have passed at end of round and increase
