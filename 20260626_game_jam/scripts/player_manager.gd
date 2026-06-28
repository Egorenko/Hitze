class_name player_manager extends Node

var stat:Array[stats] = [
preload("res://scripts/stats_res/test_stats_hapiness1.tres"), 
preload("res://scripts/stats_res/test_stats_heat1.tres"),
preload("res://scripts/stats_res/test_stats_money1.tres")
]

var event:Array[events] = [
preload("res://scripts/events/events_res/event_happines_0.tres"),
preload("res://scripts/events/events_res/event_heat_max.tres")
]

func on_lose() -> void:
	#load and overlay lose_screen
	pass
