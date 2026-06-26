@abstract class_name stats extends Resource

@export var name:String = "/Name"
@export var icon:Image
@export var max:float = 100.0
@export var start:float = 50.0
@export var min:float = 0.0

var cur:float = start

@abstract func on_min() -> void
@abstract func on_max() -> void

enum operants{
	mult = 0,
	div = 1,
	add = 2,
	sub = 3
}

func update() -> void:
	if cur <= min:
		on_min()
		return
	
	if cur >= max:
		on_max()
		return

func change(value:float, op:operants) -> void:
	match op:
		0:
			cur = cur * value
		1:
			cur = cur / value
		2:
			cur = cur + value
		3:
			cur = cur - value
	update()
