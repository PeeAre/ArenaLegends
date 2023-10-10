extends Entity
class_name Camera

const RAY_LENGTH = 32
const RAY_COLISSION_LAYER = 8

var camera: Camera3D = null
var motion_direction: Vector2i = Vector2i.ZERO
var area_ray_collided_with: Dictionary = {}
var prev_hovered_area_id: int = 0
var prev_pressed_area_id: int = 0

func _ready() -> void:
	expected_signals["device_moved"] = _if_signal_device_moved
	expected_signals["device_scrolled"] = _if_signal_device_scrolled
	expected_signals["mouse_button_pressed"] = _if_signal_mouse_button_pressed
	camera = $Camera3D as Camera3D
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	rotate_y(PI/4)
	camera.rotate_x(-PI/4)
	position = Hub.player.position * Vector3(1, 0, 1)
	camera.position.x = 0
	camera.position.z = pow(Hub.arena.distanceFromTarget, 0.5)
	camera.position.y = pow(Hub.arena.distanceFromTarget, 0.5) + Hub.player.position.y

func _process(delta):
	move(delta)
	emit_mouse_hovered()

func emit_mouse_hovered() -> void:
	if Hub.game_mode != Hub.GameMode.MOVING && \
			Hub.game_mode != Hub.GameMode.SHOOTING:
		return
	
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
