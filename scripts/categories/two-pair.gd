extends CategoryInfo

class_name TwoPair


func check_validity() -> void:
	valid = false
	
	var pairs: int = 0
	var banned_face: int = -1
	
	for dice in GameData.scoring_dice_list:
		# Check for a pair
		if GameData.scoring_dice_list.count(dice) >= 2 and dice != banned_face:
			banned_face = dice
			pairs += 1
			
			# Exit if a two pair is found
			if pairs == 2:
				break
		
	# Valid if 2 pairs are found
	if pairs >= 2:
		valid = true
	
	if valid:
		label.add_theme_color_override("font_color", Color.YELLOW)
	else:
		label.add_theme_color_override("font_color", Color.WHITE)

func score_category():
	pass
