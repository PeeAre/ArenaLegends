class Handler:

	func key_handle(node: Player, event: InputEventKey) -> void:
		for motion in node.motions:
			if event.is_action_pressed(motion):
				node.direction += node.motions[motion]
			
			if event.is_action_released(motion):
				node.direction -= node.motions[motion]


	func mouse_handle(node: Player, event: InputEventMouse) -> void:
		if event is InputEventMouseButton:
			pass
