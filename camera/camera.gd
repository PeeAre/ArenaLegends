extends Marker3D
class_name Camera

const Handler = preload("res://camera/handler.gd")
const RAY_LENGTH = 1000

@export var Distance: Vector3 = Vector3(0, 0, 0)
@export var Target: NodePath

signal mouseover(area_id: int)

var handler
var target: Node
var camera: Camera3D
var mouseMovement: Vector2i
var covered_area_id: int = 0
var grid_size: Vector2i


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	handler = Handler.Handler.new()
	target = get_node(Target) as Node3D
	camera = $Camera3D as Camera3D
	rotate_x(-PI/4)
	rotate_y(PI/4)
	camera.transform.origin = Distance
	position = target.position

func _physics_process(delta):
	var normalizedBasis = get_parent().transform.basis.rotated(Vector3.UP, PI/4)
	position += transform.basis.x * mouseMovement.x * 0.2
	position += normalizedBasis.z * mouseMovement.y * 0.2
	
	if global_position.x < 0.5:
		global_position.x = 0.5

	if global_position.x > grid_size.x-0.5:
		global_position.x = grid_size.x-0.5

	if global_transform.origin.z < 0.5:
		global_transform.origin.z = 0.5
		
	if global_transform.origin.z > grid_size.y-0.5:
		global_transform.origin.z = grid_size.y-0.5
	
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
		mouseMovement = handler.mouse_handle(self, event as InputEventMouse, get_viewport().size)
