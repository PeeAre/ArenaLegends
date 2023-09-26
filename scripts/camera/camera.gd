extends Entity
class_name Camera

const RAY_LENGTH = 32
const RAY_COLISSION_LAYER = 8

var camera: Camera3D = null
var handler = null
var motion_direction: Vector2i = Vector2i.ZERO
var mouse_scrolling_direction: int = 0
var area_ray_collided_with: Dictionary = {}
var prev_hovered_area_id: int = 0
var prev_pressed_area_id: int = 0

func _ready() -> void:
	camera = $Camera3D as Camera3D
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	rotate_y(PI/4)
	camera.rotate_x(-PI/4)
	position = Hub.player.position * Vector3(1, 0, 1)
	camera.position.x = 0
	camera.position.z = pow(Hub.arena.distanceFromTarget, 0.5)
	camera.position.y = pow(Hub.arena.distanceFromTarget, 0.5) + Hub.player.position.y

func _physics_process(delta):
	move(delta)
	scroll(delta)
	signalize_ray_collision()

func _input(event: InputEvent) -> void:
	handle_mouse_event(event)
	handle_keyboard_event(event)

func handle_keyboard_event(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("move_right"):
			motion_direction = Vector2i.RIGHT
		if event.is_action_pressed("move_back"):
			motion_direction = Vector2i.DOWN
		if event.is_action_pressed("move_left"):
			motion_direction = Vector2i.LEFT
		if event.is_action_pressed("move_forward"):
			motion_direction = Vector2i.UP

func handle_mouse_event(event: InputEvent) -> void:
	if event is InputEventMouse:
		if event is InputEventMouseMotion:
			set_motion_direction(event)
			
		if event is InputEventMouseButton:
#<<<<<<< HEAD
#			if !ray_collision_checking_result.is_empty():
#				if event.is_action_pressed("left_mouse_button"):
#					if hovered_area_id != pressed_area_id:
#						mouse_left_pressed.emit(hovered_area_id)
#						pressed_area_id = hovered_area_id
#					else:
#						pressed_area_id = 0
#						mouse_left_pressed.emit(pressed_area_id)
#						mouse_hovered.emit(hovered_area_id)	
#		mouse_movement_direction = handler.mouse_handle(camera, event as InputEventMouse, scroll_range, get_viewport().size)
#	else :
#		if event is InputEventKey:
#			if event.pressed and event.keycode == KEY_ESCAPE:
#				get_tree().quit()
#
#func _process(delta):
#	mouse_movement_direction = Vector2i.ZERO
#	if Input.is_action_pressed("move_right"):
#		mouse_movement_direction = Vector2i.RIGHT
#	if Input.is_action_pressed("move_back"):
#		mouse_movement_direction = Vector2i.DOWN
#	if Input.is_action_pressed("move_left"):
#		mouse_movement_direction = Vector2i.LEFT
#	if Input.is_action_pressed("move_forward"):
#		mouse_movement_direction = Vector2i.UP
#=======
			signalize_mouse_button_pressed(event)
			set_mouse_scrolling_direction(event)

func set_motion_direction(event: InputEventMouseMotion) -> void:
	var result_motion: Vector2i = Vector2i.ZERO
	var mouse_motion: Vector2 = event.position
	
	if mouse_motion.x == 0:
		result_motion.x = -1
	elif mouse_motion.x == get_viewport().size.x - 1:
		result_motion.x = 1
	
	if mouse_motion.y == 0:
		result_motion.y = -1
	elif mouse_motion.y == get_viewport().size.y - 1:
		result_motion.y = 1
	
	motion_direction = result_motion

func detect_window_borders() -> void:
	if position.x < 0:
		position.x = 0

	if position.x > Hub.arena.gridSize.x - pow(Hub.arena.distanceFromTarget, 0.5) + 1:
		position.x = Hub.arena.gridSize.x - pow(Hub.arena.distanceFromTarget, 0.5) + 1

	if position.z < 0:
		position.z = 0

	if position.z > Hub.arena.gridSize.y - pow(Hub.arena.distanceFromTarget, 0.5) + 1:
		position.z = Hub.arena.gridSize.y - pow(Hub.arena.distanceFromTarget, 0.5) + 1

func move(delta: float) -> void:
	position += transform.basis.x * motion_direction.x * 10 * delta
	position += transform.basis.z * motion_direction.y * 10 * delta
	detect_window_borders()

func set_mouse_scrolling_direction(event: InputEventMouseButton) -> void:
	if event.is_action_pressed("scroll_up"):
		if camera.position.y > Hub.arena.scrollRange.x:
			mouse_scrolling_direction = -1
			return
	elif event.is_action_pressed("scroll_down"):
		if camera.position.y < Hub.arena.scrollRange.y:
			mouse_scrolling_direction = 1
			return

func scroll(delta: float) -> void:
	camera.position += camera.transform.basis.z * delta * 20 * mouse_scrolling_direction
	mouse_scrolling_direction = 0

func set_area_ray_collided_with() -> void:
	var space_state = get_world_3d().direct_space_state
	var mouse_position = get_viewport().get_mouse_position()
	var origin = camera.project_ray_origin(mouse_position)
	var end = origin + camera.project_ray_normal(mouse_position) * RAY_LENGTH
	var query = PhysicsRayQueryParameters3D.create(origin, end, RAY_COLISSION_LAYER)
	query.collide_with_areas = true
	area_ray_collided_with = space_state.intersect_ray(query)

func signalize_ray_collision() -> void:
	set_area_ray_collided_with()
	var collision_result: Dictionary = area_ray_collided_with

	if !collision_result.is_empty():
		var hovered_area_id = collision_result["collider_id"]

		if prev_hovered_area_id != hovered_area_id:
			prev_hovered_area_id = hovered_area_id
			EventBus.mouse_hovered.emit(hovered_area_id)
	else:
		prev_hovered_area_id = 0
		EventBus.mouse_hovered.emit(prev_hovered_area_id)

func signalize_mouse_button_pressed(event: InputEventMouseButton) -> void:
	if !area_ray_collided_with.is_empty():
		if event.is_action_pressed("left_mouse_button"):
			var hovered_area_id = area_ray_collided_with["collider_id"]
			if hovered_area_id != prev_pressed_area_id:
				prev_pressed_area_id = hovered_area_id
				EventBus.mouse_left_pressed.emit(hovered_area_id)
			else:
				prev_pressed_area_id = 0
				EventBus.mouse_left_pressed.emit(prev_pressed_area_id)
				EventBus.mouse_hovered.emit(hovered_area_id)
