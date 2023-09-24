class EnvironmentGenerator:
	var tile_scene: PackedScene = preload("res://scenes/tile.tscn")
	var tile_size: Vector3 = Vector3.ZERO
	var grid_size: Vector2i = Vector2i.ZERO
	
	
	func _init() -> void:
		self.tile_size = (tile_scene.instantiate() as Tile).get_size()
		self.grid_size = Hub.arena.gridSize
		
		generate_grid(Hub.arena)
		create_camera()
	
	func generate_grid(arena: Arena) -> void:
		var coordinates: Vector2 = Vector2.ZERO
		
		for y in range(0, grid_size.y, tile_size.x):
			for x in range(0, grid_size.x, tile_size.x):
				var tile = tile_scene.instantiate() as Entity
				
				arena.add_child(tile)
				tile.translate(Vector3(x, 0, y))
	
	func create_camera() -> void:
		var camera: Camera = preload("res://scenes/camera.tscn").instantiate()
		Hub.arena.add_child(camera)
		Hub.camera = camera
