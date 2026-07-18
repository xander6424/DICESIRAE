extends PieceInfo

class_name Pawn

# ABILITY:
# Add +10 to addition score for first 2 dice scored.
	# Enchances to a random chess piece after 2 rounds.
		# No secret synergies.

const MAX_SCORING: int = 2
const MAX_ROUNDS: int = 2

var times_scored: int = 0
var rounds_passed: int = 0

func dice_scored(dice: DiceInfo) -> Array[int]:
	score_values[0] = 0
	
	if times_scored < MAX_SCORING:
		score_values[0] = 15
		times_scored += 1
	
	return score_values

func reset_values() -> void:
	times_scored = 0

# check if 2 rounds have passed at end of round and increase
