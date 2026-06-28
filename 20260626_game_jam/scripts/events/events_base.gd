@abstract class_name events extends Resource

@export var name:String = "/EventName"
@export var window:CompressedTexture2D = null

@export var condition:event_conditions = null

func activate() -> void:
	if condition:
		if condition.check():
			on_activate()
		else:
			print("condition not fullfilled")
	else:
		print("has no condition")

@abstract func on_activate() -> void
