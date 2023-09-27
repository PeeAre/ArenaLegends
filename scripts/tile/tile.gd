extends Entity
class_name Tile

var area_collider_id: int
var material: Material = null
var is_selected: bool = false


func _ready():
	expected_signals["mouse_hovered"] = _if_mouse_hovered
	expected_signals["object_selected"] = _if_signal_object_selected
	area_collider_id = ($AreaMesh/AreaCollider as Area3D).get_instance_id()
	material = ($AreaMesh as MeshInstance3D).get_active_material(0)

func get_size() -> Vector3:
	return ($Body/BodyMesh as MeshInstance3D).get_aabb().size

func _if_mouse_hovered(area_id: int):
	if area_collider_id == area_id:
		material.set("shader_parameter/hovered", true)
	else:
		material.set("shader_parameter/hovered", false)

func _if_signal_object_selected(area_id: int):
	if area_collider_id == area_id:
		material.set("shader_parameter/selected", true)
		EventBus.tile_selected.emit(position)
	else:
		material.set("shader_parameter/selected", false)
