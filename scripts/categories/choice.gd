extends CategoryInfo

class_name Choice


func check_validity() -> void:
	valid = false
	
	if GameData.scoring_dice_list.size() > 0:
		valid = true
	
	if valid:
		label.add_theme_color_override("font_color", Color.YELLOW)
	else:
		label.add_theme_color_override("font_color", Color.WHITE)

func score_category() -> int:
	for dice in GameData.scoring_dice_list:
		total += dice
	
	return total
