extends Entity
class_name Camera

signal mouse_hovered(area_id: int)
signal mouse_left_pressed(area_id: int)

const RAY_LENGTH = 32
const CAMERA_HANDLER_TYPE = preload("res://scripts/camera/camera_handler.gd").CameraHandler

var camera: Camera3D = null
var handler: CAMERA_HANDLER_TYPE = null
var mouse_movement_direction: Vector2i = Vector2i.ZERO
var hovered_area_id: int = 0
var pressed_area_id: int = 0

var scroll_range: Vector2 = Vector2(2, 4)
var grid_size: Vector2i = Vector2i.ZERO
var distance_from_target: float = 2.5
var initial_observation_target: Node3D = null

var ray_collision_checking_result

func _ready() -> void:
	scroll_range = Hub.arena.scrollRange
	grid_size = Hub.arena.gridSize
	distance_from_target = Hub.arena.distanceFromTarget
	initial_observation_target = Hub.arena.get_node(Hub.arena.initialObservationTarget)
	
	camera = $Camera3D as Camera3D
	handler = CAMERA_HANDLER_TYPE.new()
	self.grid_size = grid_size
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	
	var target_position = initial_observation_target.position
	
	rotate_y(PI/4)
	camera.rotate_x(-PI/4)
	transform.orthonormalized()
	camera.transform.orthonormalized()
	
	position = target_position * Vector3(1, 0, 1)
	camera.position.z = pow(distance_from_target, 0.5)
	camera.position.y = pow(distance_from_target, 0.5) + target_position.y

func _physics_process(delta):
	position += transform.basis.x * mouse_movement_direction.x * 0.1
	position += transform.basis.z * mouse_movement_direction.y * 0.1
	
	if global_position.x < 0:
		global_position.x = 0

	if global_position.x > grid_size.x - pow(distance_from_target, 0.5) + 1:
		global_position.x = grid_size.x - pow(distance_from_target, 0.5) + 1

	if global_position.z < 0:
		global_position.z = 0

	if global_position.z > grid_size.y - pow(distance_from_target, 0.5) + 1:
		global_position.z = grid_size.y - pow(distance_from_target, 0.5) + 1
	
	var space_state = get_world_3d().direct_space_state
	var mousepos = get_viewport().get_mouse_position()

	var origin = camera.project_ray_origin(mousepos)
	var end = origin + camera.project_ray_normal(mousepos) * RAY_LENGTH
	var query = PhysicsRayQueryParameters3D.create(origin, end, 8)
	query.collide_with_areas = true
	
	ray_collision_checking_result = space_state.intersect_ray(query)
	
	if !ray_collision_checking_result.is_empty():
		var area_id = ray_collision_checking_result["collider_id"]
		
		if hovered_area_id != area_id:
			mouse_hovered.emit(area_id)
			hovered_area_id = area_id
	elif hovered_area_id != 0:
		hovered_area_id = 0
		mouse_hovered.emit(hovered_area_id)

func _input(event: InputEvent) -> void:
	if event is InputEventMouse:
		if event is InputEventMouseButton:
			if !ray_collision_checking_result.is_empty():
				if event.is_action_pressed("left_mouse_button"):
					if hovered_area_id != pressed_area_id:
						mouse_left_pressed.emit(hovered_area_id)
						pressed_area_id = hovered_area_id
					else:
						pressed_area_id = 0
						mouse_left_pressed.emit(pressed_area_id)
						mouse_hovered.emit(hovered_area_id)	
		mouse_movement_direction = handler.mouse_handle(camera, event as InputEventMouse, scroll_range, get_viewport().size)
	else :
		if event is InputEventKey:
			if event.pressed and event.keycode == KEY_ESCAPE:
				get_tree().quit()

func _process(delta):
	mouse_movement_direction = Vector2i.ZERO
	if Input.is_action_pressed("move_right"):
		mouse_movement_direction = Vector2i.RIGHT
	if Input.is_action_pressed("move_back"):
		mouse_movement_direction = Vector2i.DOWN
	if Input.is_action_pressed("move_left"):
		mouse_movement_direction = Vector2i.LEFT
	if Input.is_action_pressed("move_forward"):
		mouse_movement_direction = Vector2i.UP
