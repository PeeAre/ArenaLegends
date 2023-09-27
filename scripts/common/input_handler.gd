extends Node

var old_mouse_motion_direction: Vector2i = Vector2i.ZERO
var old_keyboard_motion_direction: Vector2i = Vector2i.ZERO
var motions: Dictionary = {
	"move_forward": Vector2i.UP,
	"move_back": Vector2i.DOWN,
	"move_left": Vector2i.LEFT,
	"move_right": Vector2i.RIGHT,
}


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		handle_keyboard_event(event)
	
	if event is InputEventMouse:
		handle_mouse_event(event)

func handle_keyboard_event(event: InputEventKey) -> void:
	emit_keyboard_motion(event)

func emit_keyboard_motion(event: InputEventKey) -> void:
	for motion in motions:
		if event.is_action_pressed(motion):
			old_keyboard_motion_direction += motions[motion]
		elif event.is_action_released(motion):
			old_keyboard_motion_direction -= motions[motion]
	
	EventBus.device_moved.emit(old_keyboard_motion_direction)

func handle_mouse_event(event: InputEventMouse) -> void:
		if event is InputEventMouseMotion:
			emit_mouse_motion(event)
			
		if event is InputEventMouseButton:
			emit_mouse_button_pressed(event)
			emit_mouse_scrolling(event)

func emit_mouse_motion(event: InputEventMouseMotion) -> void:
	var mouse_position: Vector2 = event.position
	var direction: Vector2i = Vector2i.ZERO
	
	if mouse_position.x == 0:
		direction.x = -1
	elif mouse_position.x == get_viewport().size.x - 1:
		direction.x = 1
	
	if mouse_position.y == 0:
		direction.y = -1
	elif mouse_position.y == get_viewport().size.y - 1:
		direction.y = 1
	
	if direction != old_mouse_motion_direction:
		EventBus.device_moved.emit(direction)
		old_mouse_motion_direction = direction

func emit_mouse_button_pressed(event: InputEventMouseButton) -> void:
	if event.is_action_pressed("left_mouse_button"):
		EventBus.mouse_button_pressed.emit(MOUSE_BUTTON_LEFT)
	elif event.is_action_pressed("right_mouse_button"):
		EventBus.mouse_button_pressed.emit(MOUSE_BUTTON_RIGHT)
	elif event.is_action_pressed("middle_mouse_button"):
		EventBus.mouse_button_pressed.emit(MOUSE_BUTTON_MIDDLE)

func emit_mouse_scrolling(event: InputEventMouseButton) -> void:
	if event.is_action_pressed("scroll_up"):
		EventBus.device_scrolled.emit("scroll_up")
	elif event.is_action_pressed("scroll_down"):
		EventBus.device_scrolled.emit("scroll_down")
