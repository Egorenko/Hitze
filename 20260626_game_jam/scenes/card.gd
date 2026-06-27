extends Sprite2D

var dragging: bool = false
var drag_start: Vector2 = Vector2.ZERO
var origin: Vector2 = Vector2.ZERO
signal card_played(direction: String)

const SWIPE_THRESHOLD: float = 150.0

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			dragging = true
			drag_start = event.position
			origin = global_position
		else:
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
	print("Swipe Right")


func _on_swipe_left() -> void:
	card_played.emit("left")
	print("Swipe Left")

func _ready() -> void:
	get_viewport().connect("mouse_exited", _on_mouse_exited)

func _on_mouse_exited() -> void:
	if dragging:
		queue_free()
		dragging = false
		global_position = origin
