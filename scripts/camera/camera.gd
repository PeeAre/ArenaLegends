extends Entity
class_name Camera

const RAY_LENGTH = 32
const RAY_COLISSION_LAYER = 8

var camera: Camera3D = null
<<<<<<< HEAD
var motion_direction: Vector2i = Vector2i.ZERO
=======
var handler = null
var mouse_motion_direction: Vector2i = Vector2i.ZERO
var mouse_scrolling_direction: int = 0
>>>>>>> development
var area_ray_collided_with: Dictionary = {}
var prev_hovered_area_id: int = 0
var prev_pressed_area_id: int = 0

func _ready() -> void:
<<<<<<< HEAD
	expected_signals["device_moved"] = _if_signal_device_moved
	expected_signals["device_scrolled"] = _if_signal_device_scrolled
	expected_signals["mouse_button_pressed"] = _if_signal_mouse_button_pressed
=======
>>>>>>> development
	camera = $Camera3D as Camera3D
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	rotate_y(PI/4)
	camera.rotate_x(-PI/4)
	position = Hub.player.position * Vector3(1, 0, 1)
	camera.position.x = 0
	camera.position.z = pow(Hub.arena.distanceFromTarget, 0.5)
	camera.position.y = pow(Hub.arena.distanceFromTarget, 0.5) + Hub.player.position.y

<<<<<<< HEAD
func _process(delta):
	move(delta)
	emit_mouse_hovered()

func emit_mouse_hovered() -> void:
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

func set_area_ray_collided_with() -> void:
	var space_state = get_world_3d().direct_space_state
	var mouse_position = get_viewport().get_mouse_position()
	var origin = camera.project_ray_origin(mouse_position)
	var end = origin + camera.project_ray_normal(mouse_position) * RAY_LENGTH
	var query = PhysicsRayQueryParameters3D.create(origin, end, RAY_COLISSION_LAYER)
	query.collide_with_areas = true
	area_ray_collided_with = space_state.intersect_ray(query)

func detect_arena_borders() -> void:
=======
func _physics_process(delta):
	move(delta)
	scroll(delta)
	signalize_ray_collision()

func _input(event: InputEvent) -> void:
	handle_mouse_event(event)

func handle_mouse_event(event: InputEvent) -> void:
	if event is InputEventMouse:
		if event is InputEventMouseMotion:
			set_mouse_motion_direction(event)
			
		if event is InputEventMouseButton:
			signalize_mouse_button_pressed(event)
			set_mouse_scrolling_direction(event)

func set_mouse_motion_direction(event: InputEventMouseMotion) -> void:
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
	
	mouse_motion_direction = result_motion

func detect_window_borders() -> void:
>>>>>>> development
	if position.x < 0:
		position.x = 0

	if position.x > Hub.arena.gridSize.x - pow(Hub.arena.distanceFromTarget, 0.5) + 1:
		position.x = Hub.arena.gridSize.x - pow(Hub.arena.distanceFromTarget, 0.5) + 1

	if position.z < 0:
		position.z = 0

	if position.z > Hub.arena.gridSize.y - pow(Hub.arena.distanceFromTarget, 0.5) + 1:
		position.z = Hub.arena.gridSize.y - pow(Hub.arena.distanceFromTarget, 0.5) + 1

func move(delta: float) -> void:
<<<<<<< HEAD
	position += transform.basis.x * motion_direction.x * 10 * delta
	position += transform.basis.z * motion_direction.y * 10 * delta
	detect_arena_borders()

func _if_signal_device_moved(direction: Vector2i) -> void:
	motion_direction = direction

func _if_signal_device_scrolled(action: String) -> void:
	if action == "scroll_up":
		if camera.position.y > Hub.arena.scrollRange.x:
			camera.position -= camera.transform.basis.z
		
	if action == "scroll_down":
		if camera.position.y < Hub.arena.scrollRange.y:
			camera.position += camera.transform.basis.z

func _if_signal_mouse_button_pressed(button: int) -> void:
	match button:
		MOUSE_BUTTON_LEFT:
			if !area_ray_collided_with.is_empty():
				var hovered_area_id = area_ray_collided_with["collider_id"]

				if hovered_area_id != prev_pressed_area_id:
					prev_pressed_area_id = hovered_area_id
					EventBus.object_selected.emit(hovered_area_id)

#func signalize_mouse_button_pressed(event: InputEventMouseButton) -> void:
#	if !area_ray_collided_with.is_empty():
#		if event.is_action_pressed("left_mouse_button"):
#			var hovered_area_id = area_ray_collided_with["collider_id"]
#			if hovered_area_id != prev_pressed_area_id:
#				prev_pressed_area_id = hovered_area_id
#				EventBus.mouse_left_pressed.emit(hovered_area_id)
#			else:
#				prev_pressed_area_id = 0
#				EventBus.mouse_left_pressed.emit(prev_pressed_area_id)
#				EventBus.mouse_hovered.emit(hovered_area_id)
=======
	position += transform.basis.x * mouse_motion_direction.x * 10 * delta
	position += transform.basis.z * mouse_motion_direction.y * 10 * delta
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
>>>>>>> development
