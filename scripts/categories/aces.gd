extends CategoryInfo

class_name Aces


func check_validity() -> void:
	valid = false
	
	for dice in GameData.scoring_dice_list:
		if dice == 1:
			valid = true
			break
	
	if valid:
		label.add_theme_color_override("font_color", Color.YELLOW)
	else:
		label.add_theme_color_override("font_color", Color.WHITE)

func score_category() -> int:
	for dice in GameData.scoring_dice_list:
		if dice == 1:
			total += dice
	
	label.add_theme_color_override("font_color", Color.WHITE)
	
	return total
