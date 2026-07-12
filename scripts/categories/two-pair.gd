extends CategoryInfo

class_name TwoPair


func check_hand_existance(dice_list: Array[DiceInfo]) -> void:
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

func check_saved_existance(dice_list: Array[DiceInfo]) -> void:
	exists_in_saved = false
	valid_dice_list.clear()
	
	var pairs: int = 0
	var banned_faces: Array[int] = []
	var scoring_value_list: Array[int] = []
	
	# Create array of face values
	for i in dice_list.size():
		var index: int = dice_list[i].current_face_index
		scoring_value_list.append(dice_list[i].faces[index].face_value)
	
	for face in scoring_value_list:
		# Check for a pair
		if scoring_value_list.count(face) >= 2 and !(face in banned_faces):
			var dice_added: int = 0
			banned_faces.append(face)
			pairs += 1
			
			# Only grab valid dice pair
			for i in dice_list.size():
				var index: int = dice_list[i].current_face_index
				if dice_list[i].faces[index].face_value == face:
					valid_dice_list.append(dice_list[i])
					dice_added += 1
					
					if dice_added == 2:
						break
			
			# Exit if a two pair is found
			if pairs == 2:
				break
		
	# Valid if 2 pairs are found
	if pairs >= 2:
		exists_in_saved = true
	else:
		valid_dice_list.clear()
	
	# test output
	#print("TWO PAIR: ", valid_dice_list)
