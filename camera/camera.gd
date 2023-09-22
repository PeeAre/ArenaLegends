extends Marker3D
class_name Camera

const Handler = preload("res://camera/handler.gd")
const RAY_LENGTH = 1000

@export var Distance: int = 2
@export var Target: NodePath

signal mouseover(area_id: int)

var handler
var target: Node
var camera: Camera3D
var mouseMovement: Vector2i
var covered_area_id: int = 0
var grid_size: Vector2i
var old_position: Vector3


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	handler = Handler.Handler.new()
	target = get_node(Target) as Node3D
	camera = $Camera3D as Camera3D
	rotate_y(PI/4)
	camera.rotate_x(-PI/4)
	transform.orthonormalized()
	camera.transform.orthonormalized()
	position = target.position * Vector3(1, 0, 1)
	camera.position.z = pow(Distance, 0.5)
	camera.position.y = pow(Distance, 0.5) + target.position.y

func _physics_process(delta):
	position += transform.basis.x * mouseMovement.x * 0.1
	position += transform.basis.z * mouseMovement.y * 0.1
	
	if global_position.x < 0:
		global_position.x = 0

	if global_position.x > grid_size.x - pow(Distance, 0.5) + 1:
		global_position.x = grid_size.x - pow(Distance, 0.5) + 1

	if global_position.z < 0:
		global_position.z = 0
		
	if global_position.z > grid_size.y - pow(Distance, 0.5) + 1:
		global_position.z = grid_size.y - pow(Distance, 0.5) + 1
	
	if old_position != global_transform.origin:
		print("POS", position)
		old_position = global_transform.origin
	
	var space_state = get_world_3d().direct_space_state
	var mousepos = get_viewport().get_mouse_position()

	var origin = camera.project_ray_origin(mousepos)
	var end = origin + camera.project_ray_normal(mousepos) * RAY_LENGTH
	var query = PhysicsRayQueryParameters3D.create(origin, end, 8)
	query.collide_with_areas = true
	
	var result = space_state.intersect_ray(query)
	
	
	
	if !result.is_empty():
		var area_id = result["collider_id"]
		
		if covered_area_id != area_id:
			mouseover.emit(area_id)
			covered_area_id = area_id
	elif covered_area_id != 0:
		covered_area_id = 0
		mouseover.emit(covered_area_id)

func _input(event: InputEvent) -> void:
	if event is InputEventMouse:
		mouseMovement = handler.mouse_handle(camera, event as InputEventMouse, get_viewport().size)
