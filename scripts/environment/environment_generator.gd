class EnvironmentGenerator:
	
	var tile_scene: PackedScene = preload("res://scenes/tile.tscn")
	var arena: Arena = null
	var tile_size: Vector3 = Vector3.ZERO
	var grid_size: Vector2i = Vector2i.ZERO
	
	
	func _init(arena: Arena) -> void:
		self.arena = arena
		self.grid_size = arena.GridSize
		self.tile_size = (tile_scene.instantiate() as Tile).get_size()
		generate_grid()
	
	func generate_grid() -> void:
		var coordinates: Vector2 = Vector2.ZERO
		
		for y in range(0, grid_size.y, tile_size.x):
			for x in range(0, grid_size.x, tile_size.x):
				var tile = tile_scene.instantiate() as Entity
				
				arena.add_child(tile)
				tile.translate(Vector3(x, 0, y))
