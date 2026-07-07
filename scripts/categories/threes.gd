extends CategoryInfo

class_name Threes

const VALUE = 3


func check_validity() -> void:
	valid = false
	
	if VALUE in GameData.scoring_dice_list:
		valid = true
	
	if valid:
		label.add_theme_color_override("font_color", Color.YELLOW)
	else:
		label.add_theme_color_override("font_color", Color.WHITE)

func score_category():
	for dice in GameData.scoring_dice_list:
		if dice == VALUE:
			total += dice
	
	return total
