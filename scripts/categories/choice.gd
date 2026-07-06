extends CategoryInfo

class_name Choice


func check_validity() -> bool:
	valid = false
	
	if GameData.scoring_dice_list.size() > 0:
		valid = true
	
	return valid

func score_category() -> int:
	for dice in GameData.scoring_dice_list:
		total += dice
	
	return total
