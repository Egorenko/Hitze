@abstract class_name card extends Resource

@export var name: String = "/CardName"
@export var text: String = "/CardText"
@export var stats: Dictionary

@abstract func on_yes() -> void

@abstract func on_no() -> void

func apply(st: stats) -> void:
	for card_stat in stats:
		for player_stat in st:
			if card_stat == player_stat.name:
				player_stat.change(stats[card_stat], 0)   
