extends CategoryInfo

class_name Fives

const VALUE = 5


func check_hand_existance(dice_list: Array[DiceInfo]) -> bool:
	exists_in_hand = false
	
	for i in dice_list.size():
		var index: int = dice_list[i].current_face_index
		if dice_list[i].faces[index].face_value == VALUE:
			exists_in_hand = true
			break
	
	return exists_in_hand

func score_category() -> int:
	for dice in GameData.scoring_dice_list:
		if dice == VALUE:
			total += dice
	
	return total
