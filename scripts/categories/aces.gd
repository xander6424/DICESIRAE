extends CategoryInfo

class_name Aces

const VALUE = 1


func check_validity() -> bool:
	valid = false
	
	if VALUE in DiceManager.scoring_value_list:
		valid = true
	
	return valid

func score_category() -> int:
	for dice in DiceManager.scoring_value_list:
		if dice == VALUE:
			total += dice
	
	return total
