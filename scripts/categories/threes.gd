extends CategoryInfo

class_name Threes

const VALUE = 3


func check_hand_existance(dice_list: Array[DiceInfo]) -> void:
	exists_in_hand = false
	
	for i in dice_list.size():
		var index: int = dice_list[i].current_face_index
		if dice_list[i].faces[index].face_value == VALUE:
			exists_in_hand = true
			break

func score_category():
	for dice in DiceManager.scoring_value_list:
		if dice == VALUE:
			total += dice
	
	return total
