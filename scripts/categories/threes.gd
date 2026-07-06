extends CategoryInfo

class_name Threes

const VALUE = 3


func check_validity() -> bool:
	valid = false
	
	if VALUE in DiceManager.scoring_value_list:
		valid = true
	
	return valid

func score_category():
	for dice in DiceManager.scoring_value_list:
		if dice == VALUE:
			total += dice
	
	return total
