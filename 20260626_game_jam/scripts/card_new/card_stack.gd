class_name card_stack extends Resource

@export var cards:Array[card_new]
##devides the propability even between all cards
@export var all_same_probpability:bool = false
##how often (every) card can appear
@export var appearances:int = 1

func choose_card() -> card_new:
	if !all_same_probpability:
		for el in cards:
			#[0..100]
			if randf() * 100 >= el.propability:
				return el
	#if all same or (somehow) nothing in first try
	var rand = randi_range(0, cards.size()-1)
	return cards[rand]
