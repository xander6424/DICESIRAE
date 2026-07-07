extends CategoryInfo

class_name Twos

const VALUE = 2


func check_hand_existance(dice_list: Array[DiceInfo]) -> bool:
	exists_in_hand = false
	
	for i in dice_list.size():
		var index: int = dice_list[i].current_face_index
		if dice_list[i].faces[index].face_value == VALUE:
			exists_in_hand = true
			break
	
	return exists_in_hand

func score_category():
	for dice in DiceManager.scoring_value_list:
		if dice == VALUE:
			total += dice
	
	return total
