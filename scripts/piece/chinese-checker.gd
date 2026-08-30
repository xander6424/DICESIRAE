extends PieceInfo

class_name ChineseChecker

# ABILITY:
# Add +3 to mult score for every odd number scored.
	# No secret synergies.

const MULT_VALUE: int = 3


func dice_scored(dice: DiceInfo) -> Array[int]:
	if dice.faces[dice.current_face_index].face_value % 2 != 0:
		return [0, MULT_VALUE]
	
	return [0, 0]
