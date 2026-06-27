extends Node2D

var card = preload("res://scenes/card.tscn")
var card_on_feld:bool = false

func spawn_card() -> void:
	if card_on_feld:
		return
	print("card")
	var inst = card.instantiate()
	add_child(inst)
	inst.card_played.connect(_on_card_played)
	card_on_feld = true

func _on_card_played(direction: String) -> void:
	card_on_feld = false
