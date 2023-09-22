extends Node3D

class_name Tile

var area_collider: Area3D
var material: Material
var is_selected: bool


func _ready():
	area_collider = $AreaMesh/AreaCollider as Area3D
	material = ($AreaMesh as MeshInstance3D).get_active_material(0)
	is_selected = material.get("shader_parameter/selected")

func _process(delta):
	pass

func mouseover_connect(signal_target: Signal):
	signal_target.connect(_highlight)

func _highlight(area_id: int):
	if area_collider.get_instance_id() == area_id:
		material.set("shader_parameter/selected", true)
		print("tile loacal: ", position)
		print("tile gloabal: ", global_position)
	else:
		material.set("shader_parameter/selected", false)
