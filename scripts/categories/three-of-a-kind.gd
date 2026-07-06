extends CategoryInfo

class_name ThreeOfAKind


func check_validity() -> bool:
	valid = false
	
	for dice in GameData.scoring_dice_list:
		if GameData.scoring_dice_list.count(dice) >= 3:
			valid = true
			break
	
	return valid

func score_category():
	for dice in GameData.scoring_dice_list:
		if GameData.scoring_dice_list.count(dice) >= 3:
			total += dice * 3
			break
	
	return total
