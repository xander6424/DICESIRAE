extends CategoryInfo

class_name TwoPair


func check_hand_existance(dice_list: Array[DiceInfo]) -> bool:
	exists_in_hand = false
	
	var pairs: int = 0
	var banned_face: int = -1
	var scoring_value_list: Array[int] = []
	
	# Create array of face values
	for i in dice_list.size():
		var index: int = dice_list[i].current_face_index
		scoring_value_list.append(dice_list[i].faces[index].face_value)
	
	for face in scoring_value_list:
		# Check for a pair
		if scoring_value_list.count(face) >= 2 and face != banned_face:
			banned_face = face
			pairs += 1
			
			# Exit if a two pair is found
			if pairs == 2:
				break
		
	# Valid if 2 pairs are found
	if pairs >= 2:
		exists_in_hand = true
	
	return exists_in_hand

func score_category():
	var pairs: int = 0
	var banned_face: int = -1
	
	for dice in DiceManager.scoring_value_list:
		# Check for a pair
		if DiceManager.scoring_value_list.count(dice) >= 2 and dice != banned_face:
			total += dice * 2
			banned_face = dice
			pairs += 1
			
			# Exit if a two pair is found
			if pairs == 2:
				break
		
	if pairs < 2:
		total = 0
	
	return total
