extends CategoryInfo

class_name Twos

const VALUE = 2


func check_validity() -> bool:
	valid = false
	
	if VALUE in GameData.scoring_dice_list:
		valid = true
	
	return valid

func score_category():
	for dice in GameData.scoring_dice_list:
		if dice == VALUE:
			total += dice
	
	return total
