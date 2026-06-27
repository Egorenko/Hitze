extends Node2D

var card_scene = preload("res://scenes/card.tscn")
var card_praemie = preload("res://scripts/cards_res/card_praemie.tres")
var card_baume = preload("res://scripts/cards_res/card_baume.tres")
var card_windrad = preload("res://scripts/cards_res/card_windrad.tres")
var test_happiness = preload("res://scripts/stats_res/test_stats_hapiness1.tres")
var test_heat = preload("res://scripts/stats_res/test_stats_heat1.tres")
var test_money = preload("res://scripts/stats_res/test_stats_money1.tres")
var card_on_feld:bool = false
var card_pool: Array[card] = []
var card_stack: Array[card] = []
var current_card_node: Node = null
var test_stats: Array[stats] = []
@onready var money = $LineMoney
@onready var heat = $LineHeat
@onready var happines = $LineHappiines
@onready var yes = $ButtonYes
@onready var no = $ButtonNo

func _ready() -> void:
	test_stats.append(test_happiness)
	test_stats.append(test_heat)
	test_stats.append(test_money)
	_build_card_pool()
	_shuffle_stack()
	yes.pressed.connect(func(): _button_swipe("right"))
	no.pressed.connect(func(): _button_swipe("left"))

func _build_card_pool() -> void:
	card_pool.append(card_praemie.duplicate())
	card_pool.append(card_baume.duplicate())
	card_pool.append(card_windrad.duplicate())
	
func _shuffle_stack() -> void:
	card_stack = card_pool.duplicate()
	card_stack.shuffle()
	
func spawn_card() -> void:
	if card_on_feld:
		return
		
	if card_stack.is_empty():
		print("Kein Karten mehr!")
		on_win()
		return
		
	var card_data = card_stack.pop_front()
	print("card")
	var inst = card_scene.instantiate()
	add_child(inst)
	inst.setup(card_data)  
	inst.card_played.connect(_on_card_played)
	current_card_node = inst
	card_on_feld = true

func _on_card_played(direction: String) -> void:
	card_on_feld = false


func on_win() -> void:
	pass

func _button_swipe(direction: String) -> void:
	if current_card_node == null:
		return
	current_card_node.swipe_to(direction)
