extends Node

enum Size {D6, D8, D10, D12, D14, D16, D18, D20}
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
	RUBY, 
	DIAMOND, 
	GOLD, 
	EMERALD, 
	SPRING, 
	PARTY, 
	METAL, 
	GLUE, 
	BLANK
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

var starting_category_list: Array[Category] = [
	Category.ACES, 
	Category.TWOS, 
	Category.THREES, 
	Category.TWO_PAIR, 
	Category.THREE_OF_A_KIND
]
