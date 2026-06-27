class_name card_new extends Resource

@export var name: String = "/CardName"
@export var text: String = "/CardText"
@export var yes_effects:Array[card_effect]
@export var no_effects:Array[card_effect]

func on_yes() -> void:
	for el in yes_effects:
		for player_stat in PlayerManager.stat:
			if el.stat == player_stat:
				player_stat.change(el.value, el.operation)

func on_no() -> void:
	for el in no_effects:
		for player_stat in PlayerManager.stat:
			if el.stat == player_stat:
				player_stat.change(el.value, el.operation)
