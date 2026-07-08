extends CategoryInfo

class_name ThreeOfAKind


func check_hand_existance(dice_list: Array[DiceInfo]) -> void:
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

func check_saved_existance(dice_list: Array[DiceInfo]) -> void:
	exists_in_saved = false
	valid_dice_list.clear()
	
	var scoring_value_list: Array[int] = []
	
	# Create array of face values
	for i in dice_list.size():
		var index: int = dice_list[i].current_face_index
		scoring_value_list.append(dice_list[i].faces[index].face_value)
	
	for face in scoring_value_list:
		if scoring_value_list.count(face) >= 3:
			# Only grab valid 3 of a kind dice
			for i in dice_list.size():
				var index: int = dice_list[i].current_face_index
				if dice_list[i].faces[index].face_value == face:
					valid_dice_list.append(dice_list[i])
					
					if valid_dice_list.size() == 3:
						break
			
			exists_in_saved = true
			break
	
	# test output
	print("THREE OF A KIND: ", valid_dice_list)

func score_category():
	for dice in DiceManager.scoring_value_list:
		if DiceManager.scoring_value_list.count(dice) >= 3:
			total += dice * 3
			break
	
	return total
