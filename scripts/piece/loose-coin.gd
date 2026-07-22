extends PieceInfo

class_name LooseCoin

# ABILITY:
# Add the current money value to the mult score.
	# No secret synergies.


func piece_scored() -> Array[int]:
	return [0, GameData.money]
