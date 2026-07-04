extends Node

# Constant category resources
const ACES = preload("uid://d0dnckugihorb")
const TWOS = preload("uid://bdli131rdnkn8")
const THREES = preload("uid://w1i6ic0hoa5l")
const FOURS = preload("uid://dkv7n3esqthwv")
const FIVES = preload("uid://x88dmurq18bq")
const SIXES = preload("uid://coobduor34qyh")

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
	
	TWO_PAIR,
	THREE_OF_A_KIND
]
var active_category_info_list: Array[CategoryInfo] = []
