extends PieceInfo

class_name House

# ABILITY:
# Gain $2 for every randomly selected number scored.
	# No secret synergies.

const MONEY_VALUE: int = 2
var random_number: int = 0

func dice_scored(dice: DiceInfo) -> Array[int]:
	if dice.faces[dice.current_face_index].face_value == random_number:
		GameData.money += MONEY_VALUE
	
	return [0, 0]

func round_started():
	random_number = randi() % 6 + 1
	piece_description = "Gain [color=green]$" + str(MONEY_VALUE) + "[/color] for every [color=yellow]" + str(random_number) + "[/color] scored."
	
