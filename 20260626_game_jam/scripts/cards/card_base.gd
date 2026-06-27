@abstract class_name card extends Resource

@export var name: String = "/CardName"
@export var text: String = "/CardText"
@export var stats: Array[stats] = []

@abstract func on_yes() -> void

@abstract func on_no() -> void

func apply(player: player_manager) -> void:
	for card_stat in stats:
		for player_stat in player.stat:
			if card_stat.name == player_stat.name:
				player_stat.change(card_stat.cur, card_stat.operants.add)   
