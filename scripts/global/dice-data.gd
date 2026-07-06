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

enum DiceType {
	NORMAL, 
	
	RED, 
	BLUE, 
	YELLOW, 
	GREEN, 
	
	CRYSTAL, 
	GHOST, 
	MITOSIS, 
	VOID
}

enum FaceType {
	NORMAL, 
	BLANK, 
	
	RUBY, 
	DIAMOND, 
	GOLD, 
	EMERALD, 
	
	SPRING, 
	PARTY, 
	METAL, 
	GLUE
}
