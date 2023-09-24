class EnvironmentManager:
	var tile_scene: PackedScene = preload("res://scenes/tile.tscn")
	var camera_scene: PackedScene = preload("res://scenes/camera.tscn")
	var player_scene: PackedScene = preload("res://scenes/player.tscn")
	var tile_size: Vector3 = Vector3.ZERO
	var grid_size: Vector2i = Vector2i.ZERO
	var tile_dict: Dictionary = {}
	
	
	func _init() -> void:
		tile_size = (tile_scene.instantiate() as Tile).get_size()
		grid_size = Hub.arena.gridSize
		tile_dict = Hub.grid.grid
		create_field()
		spawn_player()
		create_camera()
	
	func create_field() -> void:
		var coordinates: Vector2 = Vector2.ZERO
		Hub.grid.size = Hub.arena.gridSize
		
		for y in range(0, grid_size.y * tile_size.x, tile_size.x):
			for x in range(0, grid_size.x * tile_size.z, tile_size.z):
				var tile = tile_scene.instantiate() as Entity
				Hub.arena.add_child(tile)
				tile_dict[tile] = Vector2(x, y)
				tile.translate(Vector3(x, 0, y))
	
	func create_camera() -> void:
		var camera: Camera = camera_scene.instantiate()
		Hub.arena.add_child(camera)
		Hub.camera = camera
	
	func spawn_player() -> void:
		var player: Player = player_scene.instantiate()
		Hub.arena.add_child(player)
		Hub.player = player
