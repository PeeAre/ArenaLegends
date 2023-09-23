extends Entity
class_name Tile

var area_collider_id: int
var material: Material
var is_selected: bool


func _ready():
	expected_signals["mouseover"] = _if_signal_highlight
	area_collider_id = ($AreaMesh/AreaCollider as Area3D).get_instance_id()
	material = ($AreaMesh as MeshInstance3D).get_active_material(0)
	is_selected = material.get("shader_parameter/selected")

func _process(delta):
	pass

func get_size() -> Vector3:
	return ($Body/BodyMesh as MeshInstance3D).get_aabb().size

func _if_signal_highlight(area_id: int):
	if area_collider_id == area_id:
		material.set("shader_parameter/selected", true)
		print("tile loacal: ", position)
		print("tile gloabal: ", global_position)
	else:
		material.set("shader_parameter/selected", false)
