class_name card_stack extends Resource

@export var cards:Array[card_new]
##devides the propability even between all cards
@export var all_same_probpability:bool = false
##how often (every) card can appear
@export var appearances:int = 1

func setup() -> void:
	for el in cards:
		el.amount = appearances

func is_empty() -> bool:
	return cards.is_empty()

func choose_card() -> card_new:
	if not all_same_probpability:
		for el in cards:
			#[0..100]
			if randf() * 100 >= el.propability:
				el.amount -= 1
				if not legal_card(el):
					cards.erase(el)
				return el
	#if all same or (somehow) nothing in first try
	var rand = randi_range(0, cards.size()-1)
	var chosen_card = cards[rand]
	chosen_card.amount -= 1
	if not legal_card(chosen_card):
		cards.erase(chosen_card)
	return chosen_card

func legal_card(c:card_new) -> bool:
	if c.amount <= 0:
		return false
	
	return true
