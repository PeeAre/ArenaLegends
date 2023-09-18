extends Node

class_name Observer

var cameras: Array
var platforms: Array

func _ready():
	var nodes = get_children()
	
	for node in nodes:
		if node is Camera:
			cameras.append(node)
	
		if node is Platform:
			platforms.append(node)
	
	subscribe()

func _process(delta):
	pass

func subscribe():
	for platform in platforms:
		for camera in cameras:
			platform.mouseover_connect(camera.mouseover)
