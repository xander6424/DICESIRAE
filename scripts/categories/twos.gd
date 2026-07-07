extends CategoryInfo

class_name Twos

const VALUE = 2


func check_validity() -> void:
	valid = false
	
	if VALUE in DiceManager.scoring_value_list:
		valid = true
	
	if valid:
		label.add_theme_color_override("font_color", Color.YELLOW)
	else:
		label.add_theme_color_override("font_color", Color.WHITE)

func score_category():
	for dice in DiceManager.scoring_value_list:
		if dice == VALUE:
			total += dice
	
	return total
