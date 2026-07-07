extends CategoryInfo

class_name Choice


func check_hand_existance(dice_list: Array[DiceInfo]) -> bool:
	exists_in_hand = false
	
	if dice_list.size() > 0:
		exists_in_hand = true
	
	return exists_in_hand

func score_category() -> int:
	for dice in GameData.scoring_dice_list:
		total += dice
	
	return total
