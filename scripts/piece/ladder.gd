extends PieceInfo

class_name Ladder

# ABILITY:
# Adds +1 reroll.
	# No secret synergies.

func round_started():
	GameData.bonus_rerolls += 1
