extends Node3D

class_name Platform

var area_collider: Area3D
var material: Material
var is_selected: bool


func _ready():
	area_collider = $Body/Area3D as Area3D
	material = ($Body/Mesh as MeshInstance3D).get_active_material(0)
	is_selected = material.get("shader_parameter/enable")

func _process(delta):
	pass

func mouseover_connect(signal_target: Signal):
	signal_target.connect(_highlight)

func _highlight(area_id: int):
	if area_collider.get_instance_id() == area_id:
		material.set("shader_parameter/enable", true)
	else:
		material.set("shader_parameter/enable", false)
