extends PieceInfo

class_name MancalaStone

# ABILITY:
# Adds the highest scored dice value to the mult score.
	# No secret synergies.

func piece_scored() -> Array[int]:
	var value_array: Array[int] = []
	for dice in DiceManager.scoring_dice_list:
		value_array.append(dice.faces[dice.current_face_index].face_value)
	
	return [0, value_array.max()]
