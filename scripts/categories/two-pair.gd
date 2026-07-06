extends CategoryInfo

class_name TwoPair


func check_validity() -> bool:
	valid = false
	
	var pairs: int = 0
	var banned_face: int = -1
	
	for dice in DiceManager.scoring_value_list:
		# Check for a pair
		if DiceManager.scoring_value_list.count(dice) >= 2 and dice != banned_face:
			banned_face = dice
			pairs += 1
			
			# Exit if a two pair is found
			if pairs == 2:
				break
		
	# Valid if 2 pairs are found
	if pairs >= 2:
		valid = true
	
	return valid

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
