extends CategoryInfo

class_name Sixes

const VALUE = 6


func check_validity() -> bool:
	valid = false
	
	if VALUE in GameData.scoring_dice_list:
		valid = true
	
	return valid

func score_category() -> int:
	for dice in GameData.scoring_dice_list:
		if dice == VALUE:
			total += dice
	
	return total
