extends CategoryInfo

class_name Threes

const VALUE = 3


func check_hand_existance(dice_list: Array[DiceInfo]) -> void:
	exists_in_hand = false
	
	for i in dice_list.size():
		var index: int = dice_list[i].current_face_index
		if dice_list[i].faces[index].face_value == VALUE:
			exists_in_hand = true
			break

func check_saved_existance(dice_list: Array[DiceInfo]) -> void:
	exists_in_saved = false
	valid_dice_list.clear()
	
	for i in dice_list.size():
		var index: int = dice_list[i].current_face_index
		if dice_list[i].faces[index].face_value == VALUE:
			exists_in_saved = true
			valid_dice_list.append(dice_list[i])
	
	# test output
	print("THREES: ", valid_dice_list)
