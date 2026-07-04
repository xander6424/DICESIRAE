extends Node

# Constant category resources
const ACES = preload("uid://d0dnckugihorb")
const TWOS = preload("uid://bdli131rdnkn8")
const THREES = preload("uid://w1i6ic0hoa5l")
const FOURS = preload("uid://dkv7n3esqthwv")
const FIVES = preload("uid://x88dmurq18bq")
const SIXES = preload("uid://coobduor34qyh")

const CHOICE = preload("uid://dh1qbs23toj22")
const TWO_PAIR = preload("uid://c4cblgubhmop6")
const THREE_OF_A_KIND = preload("uid://dnd8frrk8gh6n")


# Organized categories
const FULL_CATEGORY_LIST: Array[CategoryInfo] = [
	ACES,
	TWOS,
	THREES,
	FOURS,
	FIVES,
	SIXES,
	
	CHOICE,
	TWO_PAIR,
	THREE_OF_A_KIND
]
var active_category_info_list: Array[CategoryInfo] = []


# Category ID
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
var starting_category_list = [
	[Category.ACES, Category.TWOS, Category.THREES, Category.TWO_PAIR, Category.THREE_OF_A_KIND],
	[Category.ACES, Category.TWOS, Category.FOURS, Category.CHOICE, Category.TWO_PAIR]
]
