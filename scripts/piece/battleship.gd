extends PieceInfo

class_name Battleship

# ABILITY:
# A random face value adds +33 to the add score.
	# No secret synergies.

const ADD_VALUE: int = 33
var random_number: int = 0


func dice_scored(dice: DiceInfo) -> Array[int]:
	if dice.faces[dice.current_face_index].face_value == random_number:
		return [ADD_VALUE, 0]
	
	return [0, 0]

func round_started():
	random_number = randi() % 6 + 1
	piece_description = "Every [color=yellow]" + str(random_number) + "[/color] scored adds [color=aqua]+33[/color] to the [color=aqua]add score.[/color]"
	
