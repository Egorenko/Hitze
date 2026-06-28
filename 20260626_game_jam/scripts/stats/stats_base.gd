@abstract class_name stats extends Resource

@export var name:String = "/Name"
@export var icon:Image
@export var max:float = 100.0
@export var start:float = 50.0
@export var min:float = 0.0

var cur:float = start

@abstract func on_min() -> void
@abstract func on_max() -> void

func update() -> void:
	if cur <= min:
		cur = min
		on_min()
		return
	
	if cur >= max:
		cur = max
		on_max()
		return

func change(value:float, op:math_operators) -> void:
	cur = op.use(cur, value)
	update()
