extends Node


# active dice list
# all dice from draw pile
# all dice from discard pile

enum Size {
	D6 = 6, 
	D8 = 8, 
	D10 = 10, 
	D12 = 12, 
	D14 = 14, 
	D16 = 16, 
	D18 = 18, 
	D20 = 20
}

# The entire dice type (doesn't override face types)
enum DiceType {
	NORMAL, 
	
	RED, # Add value to mult score
	BLUE, # Add value to add score
	YELLOW, # ???
	GREEN, # Add value to money
	
	CRYSTAL, # Score dice no matter what
	GHOST, # Score top and bottom dice faces in scoring
	MITOSIS, # Dice duplicates and splits in two during rolling
	VOID # Extra powerful but absorbs all other scored faces
}

# For individual dice faces
enum FaceType {
	NORMAL, 
	BLANK, 
	
	RUBY, # Add face to mult score
	DIAMOND, # Add face to add score
	GOLD, # ???
	EMERALD, # Add face to money
	
	SPRING, # Free reroll to undesired face
	PARTY, # Generate 1-10 randomly
	METAL, # Prioritize opposite side
	GLUE # Sticks to prioritize opposite side. (2 uses)
}
