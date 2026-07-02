extends CategoryInfo

class_name Fours


func check_validity() -> void:
	valid = false
	
	for dice in GameData.scoring_dice_list:
		if dice == 4:
			valid = true
			break
	
	if valid:
		label.add_theme_color_override("font_color", Color.YELLOW)
	else:
		label.add_theme_color_override("font_color", Color.WHITE)

func score_category():
	for dice in GameData.scoring_dice_list:
		if dice == 4:
			total += dice
	
	label.add_theme_color_override("font_color", Color.WHITE)
	
	return total
