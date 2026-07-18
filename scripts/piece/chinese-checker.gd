extends PieceInfo

class_name ChineseChecker

# ABILITY:
# Add +3 to mult score for every odd number scored.
# Permanently add another +4 for every 13 dice scored.
	# No secret synergies.

var base_mult_score: int = 3
var odd_dice_scored: int = 0

const MULT_SCALING: int = 4
const DICE_TO_SCORE: int = 13


func dice_scored(dice: DiceInfo) -> Array[int]:
	if odd_dice_scored == DICE_TO_SCORE:
		odd_dice_scored = 0
		base_mult_score += MULT_SCALING
		piece_description = "Add +" + str(base_mult_score) + " to mult score for every odd number scored. Permanently add another +4 for every 13 dice scored."
	
	if dice.faces[dice.current_face_index].face_value % 2 != 0:
		odd_dice_scored += 1
		return [0, base_mult_score]
	
	return [0, 0]
