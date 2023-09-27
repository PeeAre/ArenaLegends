class_name Grid

var field: Dictionary = {}
var size: Vector2i = Vector2i.ZERO


func delete_border() -> void:
	var tile_scene: PackedScene = preload("res://scenes/tile.tscn")
	var tile_size = (tile_scene.instantiate() as Tile).get_size()
	
	for y in range(0, size.y * tile_size.y, tile_size.y):
		for x in range(0, size.x * tile_size.x, tile_size.x):
			pass
