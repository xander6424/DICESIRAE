extends CategoryInfo

class_name Fives


func check_validity() -> void:
	valid = false
	
	for dice in GameData.scoring_dice_list:
		if dice == 5:
			valid = true
			break
	
	if valid:
		label.add_theme_color_override("font_color", Color.YELLOW)
	else:
		label.add_theme_color_override("font_color", Color.WHITE)

func score_category() -> int:
	for dice in GameData.scoring_dice_list:
		if dice == 5:
			total += dice
	
	return total
