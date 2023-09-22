extends Node3D

class Handler:
	
	func mouse_handle(camera: Camera3D, event: InputEventMouse, viewportSize: Vector2i) -> Vector2i:
		
		var coordinates: Vector2i = Vector2i.ZERO
		
		if event is InputEventMouseMotion:
			var coordinate_x = event.position.x
			var coordinate_y = event.position.y
			
			if coordinate_x == 0:
				coordinates.x = -1;
			
			if coordinate_x == viewportSize.x - 1:
				coordinates.x = 1;
			
			if coordinate_y == 0:
				coordinates.y = -1;
			
			if coordinate_y == viewportSize.y - 1:
				coordinates.y = 1;
		
		if event is InputEventMouseButton:
			print(camera.position)
			if event.is_action_pressed("scroll_up"):
				if camera.position.y > 0:
					camera.position -= camera.transform.basis.z * 0.2
			
			if event.is_action_pressed("scroll_down"):
				if camera.position.y < 4:
					camera.position += camera.transform.basis.z * 0.2
		return coordinates
	
	func get_covered_platform():
		pass
