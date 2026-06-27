class_name player_manager extends Node

@export var stat:Array[stats] = [
load("res://scripts/stats/stats_happiness.gd"), 
load("res://scripts/stats/stats_heat.gd"),
load("res://scripts/stats/stats_money.gd")
]

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
