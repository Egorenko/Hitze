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
var card_stack_: Array[card] = []
var current_card_node: Node = null
var test_stats: Array[stats] = []
@onready var money = $stat_bars/statsbar_money
@onready var heat = $stat_bars/statsbar_temperature
@onready var happines = $stat_bars/statsbar_mood
@onready var yes = $ButtonYes
@onready var no = $ButtonNo

@onready var card_body:Sprite2D = $Card
@export var all_cards:card_stack

func _ready() -> void:
	update_stats()
	all_cards.setup()
	
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
	card_stack_ = card_pool.duplicate()
	card_stack_.shuffle()

func spawn_card() -> void:
	if not card_on_feld:
		if not all_cards.is_empty():
			load_card(all_cards.choose_card())
		else:
			print("keine karten mehr")
	else:
		print("immer noch eine karte")
		return
	
	'if card_on_feld:
		return
		
	if card_stack_.is_empty():
		print("Kein Karten mehr!")
		on_win()
		return
		
	var card_data = card_stack_.pop_front()
	print("card")
	var inst = card_scene.instantiate()
	add_child(inst)
	inst.setup(card_data)  
	inst.card_played.connect(_on_card_played)
	current_card_node = inst
	card_on_feld = true'
#
@onready var card_pos:Vector2 = card_body.global_position

func load_card(c:card_new) -> void:
	print("card spawned")
	card_body.setup(c)
	card_body.global_position = card_pos
	card_on()

func card_on() -> void:
	card_body.visible = true
	card_body.moveable = true
	card_on_feld = true
	update_stats()

func card_off() -> void:
	card_body.visible = false
	card_body.moveable = false
	card_on_feld = false
	update_stats()

func update_stats() -> void:
	money.frame = int(PlayerManager.stat[2].cur / 16.6)
	happines.frame = int(PlayerManager.stat[0].cur / 16.6)
	heat.frame = int(PlayerManager.stat[1].cur / 16.6)
	#update window
	$window_stage3_neutral.frame = int(PlayerManager.stat[0].cur / 25.0)
	for event in PlayerManager.event:
		event.activate()
#
func _on_card_played(direction: String) -> void:
	card_on_feld = false
	card_off()

#debug
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_down"):
		for el in all_cards.cards:
			print(el.name, " + ", el.amount)
	if event.is_action_pressed("ui_up"):
		print(card_pos)
	if event.is_action_pressed("ui_left"):
		for el in PlayerManager.stat:
			print(el.cur)


func on_win() -> void:
	print("WIN")
	pass

func _button_swipe(direction: String) -> void:
	if current_card_node == null:
		return
	current_card_node.swipe_to(direction)


func _on_button_no_button_down() -> void:
	if card_on_feld:
		card_body.card_data.on_no()
		card_off()
	pass # Replace with function body.

func _on_button_yes_button_down() -> void:
	if card_on_feld:
		card_body.card_data.on_yes()
		card_off()
	pass # Replace with function body.
