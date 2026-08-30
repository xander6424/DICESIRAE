extends PieceInfo

class_name Checker

# ABILITY:
# Add +16 to add score for every even number scored.
	# No secret synergies.

const ADD_VALUE: int = 16


func dice_scored(dice: DiceInfo) -> Array[int]:
	if dice.faces[dice.current_face_index].face_value % 2 == 0:
		return [ADD_VALUE, 0]
	
	return [0, 0]
