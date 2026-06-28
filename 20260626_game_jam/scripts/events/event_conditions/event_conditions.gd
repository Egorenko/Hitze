class_name event_conditions extends Resource

@export var value:float = 0.0
@export var under:bool = true
@export var stat:stats = null

##return if fullfilled
func check() -> bool:
	if stat:
		for el in PlayerManager.stat:
			#don't like names
			if el.name == stat.name:
				if under:
					return el.cur < value
				else:
					return el.cur >= value
	return false
