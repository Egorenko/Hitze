class_name player_manager extends Node

@export var stat:Array[stats] = [
load("res://scripts/stats/stats_happiness.gd"), 
load("res://scripts/stats/stats_heat.gd"),
load("res://scripts/stats/stats_money.gd")
]

func on_lose() -> void:
	#load and overlay lose_screen
	pass
