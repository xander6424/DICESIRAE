extends PieceInfo

class_name Pawn

# ABILITY:
# Add +10 to addition score for first 2 dice scored.
	# Enchances to a random chess piece after 2 rounds.
		# No secret synergies.

const ADD_VALUE: int = 15
const MAX_SCORING: int = 2
const MAX_ROUNDS: int = 2

var times_scored: int = 0
var rounds_passed: int = 0

func dice_scored(dice: DiceInfo) -> Array[int]:
	if times_scored < MAX_SCORING:
		times_scored += 1
		return [ADD_VALUE, 0]
	
	return [0, 0]

func reset_values() -> void:
	times_scored = 0

# check if 2 rounds have passed at end of round and increase
