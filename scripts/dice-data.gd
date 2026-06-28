extends Node

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

enum Type {
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

enum Face {
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

enum Category {
	ACES, 
	TWOS, 
	THREES, 
	FOURS, 
	FIVES,
	SIXES,
	
	CHOICE, 
	TWO_PAIR, 
	THREE_OF_A_KIND,
	FOUR_OF_A_KIND,
	FULL_HOUSE,
	SMALL_STRAIGHT,
	LARGE_STRAIGHT,
	DICESIRAE
}


# The starting scorecard for a given game played
var starting_category_list: Array[Category] = [
	Category.ACES, 
	Category.TWOS, 
	Category.THREES, 
	Category.TWO_PAIR, 
	Category.THREE_OF_A_KIND
]
