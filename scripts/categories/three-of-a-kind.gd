extends CategoryInfo

class_name ThreeOfAKind


func check_hand_existance(dice_list: Array[DiceInfo]) -> bool:
	exists_in_hand = false
	
	var scoring_value_list: Array[int] = []
	
	# Create array of face values
	for i in dice_list.size():
		var index: int = dice_list[i].current_face_index
		scoring_value_list.append(dice_list[i].faces[index].face_value)
	
	for face in scoring_value_list:
		if scoring_value_list.count(face) >= 3:
			exists_in_hand = true
			break
	
	return exists_in_hand

func score_category():
	for dice in DiceManager.scoring_value_list:
		if DiceManager.scoring_value_list.count(dice) >= 3:
			total += dice * 3
			break
	
	return total
