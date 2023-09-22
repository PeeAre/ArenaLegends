extends Node3D

@export var GridSize: Vector2i = Vector2i.ZERO

const tile_size: int = 1

var tile_scene: PackedScene = preload("res://entities/tile/tile2.tscn")
var grid_size: Vector2i


func _ready() -> void:
	grid_size = GridSize
	generate_grid()
	init_camera()

func init_camera() -> void:
	print(grid_size)
	var camera = $Camera as Node3D
	camera.grid_size = grid_size

func generate_grid() -> void:
	var coordinates: Vector2 = Vector2.ZERO
	for y in range(0, grid_size.y, tile_size):
		for x in range(0, grid_size.x, tile_size):
			var tile = tile_scene.instantiate() as Node3D
			add_child(tile)
			tile.global_translate(Vector3(x, 0, y))
