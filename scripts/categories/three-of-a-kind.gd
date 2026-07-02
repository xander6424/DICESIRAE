extends CategoryInfo

class_name ThreeOfAKind


func check_validity() -> void:
	valid = false
	
	for dice in GameData.scoring_dice_list:
		if GameData.scoring_dice_list.count(dice) >= 3:
			valid = true
			break
	
	if valid:
		label.add_theme_color_override("font_color", Color.YELLOW)
	else:
		label.add_theme_color_override("font_color", Color.WHITE)

func score_category():
	for dice in GameData.scoring_dice_list:
		if GameData.scoring_dice_list.count(dice) >= 3:
			total += dice * 3
			break
	
	label.add_theme_color_override("font_color", Color.WHITE)
	
	return total
