extends Sprite2D
#drag'n drop
var dragging: bool = false
var drag_start: Vector2 = Vector2.ZERO
@onready var origin:Vector2 = self.global_position

const SWIPE_THRESHOLD: float = 150.0

signal card_played(direction: String)
@export var card_data:card_new

var moveable:bool = false

@onready var label_name: Label = $LabelName
@onready var label_text: Label = $LabelText

func setup(data: card_new) -> void:
	card_data = data
	label_name.text = card_data.name
	label_text.text = card_data.text
	global_position = origin

#darg'n drop movement
func _input(event: InputEvent) -> void:
	return
	if event is InputEventMouseButton and moveable:
		if event.pressed:
			dragging = true
			drag_start = event.position
			origin = global_position
		else:
			#allways right when button pressed (not only drag'n drop)
			print("err")
			_check_swipe(event.position)
			dragging = false
	
	if event is InputEventMouseMotion and dragging:
		global_position = origin + (event.position - drag_start)


func _check_swipe(end_pos: Vector2) -> void:
	var diff: Vector2 = end_pos - drag_start
	
	if abs(diff.x) < SWIPE_THRESHOLD:
		# Zurück zur Origin
		global_position = origin
		return
	
	if diff.x > 0:
		_on_swipe_right()
	elif diff.x < 0:
		_on_swipe_left()

func _on_swipe_right() -> void:
	card_played.emit("right")
	card_data.on_yes()
	print("Swipe Right")

func _on_swipe_left() -> void:
	card_played.emit("left")
	card_data.on_no()
	print("Swipe Left")

func _ready() -> void:
	get_viewport().connect("mouse_exited", _on_mouse_exited)

func _on_mouse_exited() -> void:
	if dragging:
		queue_free()
		dragging = false
		global_position = origin

func swipe_to(direction: String) -> void:
	if direction == "right":
		global_position.x = global_position.x + 5000
	elif direction == "left":
		global_position.x = global_position.x - 5000
