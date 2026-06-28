class_name events extends Resource

@export var name:String = "/EventName"
@export var window:CompressedTexture2D = null

@export var condition:event_conditions = null
@export var eff:event_effect = null

var got_activated:bool = false

func activate() -> void:
	if got_activated:
		return
	if condition and eff:
		if condition.check():
			eff.activate()
			got_activated = !got_activated
		else:
			#print("condition not fullfilled")
			pass
	else:
		#print("has no condition")
		pass
