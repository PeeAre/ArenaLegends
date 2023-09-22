extends Node3D

class_name Observer

var cameras: Array
var platforms: Array

func _ready():
	var nodes: Array = get_all_children(self)
	
	for node in nodes:
		if node is Camera:
			cameras.append(node)
	
		if node is Tile:
			platforms.append(node)
		
	subscribe()

func get_all_children(node: Node) -> Array:
	var nodes : Array = []
	
	for n in node.get_children():
		if n.get_child_count() > 0:
			nodes.append(n)
			nodes.append_array(get_all_children(n))
		else:
			nodes.append(n)
	
	return nodes

func subscribe():
	for platform in platforms:
		for camera in cameras:
			platform.mouseover_connect(camera.mouseover)
