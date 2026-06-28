class_name events extends Resource

@export var name:String = "/EventName"
@export var window:CompressedTexture2D = null

@export var condition:event_conditions = null
@export var eff:event_effect = null

func activate() -> void:
	if condition and eff:
		if condition.check():
			eff.activate()
		else:
			print("condition not fullfilled")
	else:
		print("has no condition")
