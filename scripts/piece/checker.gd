extends PieceInfo

class_name Checker

# ABILITY:
# Add +24 to add score for every even number scored.
	# No secret synergies.

var base_add_score: int = 24


func dice_scored(dice: DiceInfo) -> Array[int]:
	if dice.faces[dice.current_face_index].face_value % 2 == 0:
		return [base_add_score, 0]
	
	return [0, 0]
