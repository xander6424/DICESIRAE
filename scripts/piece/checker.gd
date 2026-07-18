extends PieceInfo

class_name Checker

# ABILITY:
# Add +24 to add score for every even number scored.
# Permanently add another +4 for every 10 dice scored.
	# No secret synergies.

var base_add_score: int = 24
var even_dice_scored: int = 0

const ADD_SCALING: int = 4
const DICE_TO_SCORE: int = 10


func dice_scored(dice: DiceInfo) -> Array[int]:
	if even_dice_scored == DICE_TO_SCORE:
		even_dice_scored = 0
		base_add_score += ADD_SCALING
		piece_description = "Add +" + str(base_add_score) + " to add score for every even number scored. Permanently add another +4 for every 10 dice scored."
	
	if dice.faces[dice.current_face_index].face_value % 2 == 0:
		even_dice_scored += 1
		return [base_add_score, 0]
	
	return [0, 0]
