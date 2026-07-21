extends PieceInfo

class_name FamilyCar

# ABILITY:
# Adds +150 to add score if the played hand contains unique
# dice face values.
	# No secret synergies.

const ADD_VALUE: int = 150

var banned_faces: Array[int] = []
var unique_faces: bool = false


func dice_scored(dice: DiceInfo) -> Array[int]:
	var current_face: int = dice.faces[dice.current_face_index].face_value
	
	# Check if value is unique
	if current_face not in banned_faces:
		banned_faces.append(current_face)
	
	# Check if unique face values exist
	if banned_faces.size() >= 2:
		unique_faces = true
	
	return [0, 0]

func piece_scored() -> Array[int]:
	banned_faces.clear()
	
	if unique_faces:
		unique_faces = false
		return [ADD_VALUE, 0]
	
	return [0, 0]
