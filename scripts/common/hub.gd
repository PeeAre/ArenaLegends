extends Node

<<<<<<< HEAD
var grid: Grid = null
var environment_manager: EnvironmentManager = null
=======
var grid = null
var environment_manager = null
>>>>>>> development
var entities: Array[Entity] = []
var arena: Arena = null
var camera: Camera = null
var player: Player = null
var tile_size: Vector3 = Vector3.ZERO
var palyer_spawn_position: Vector3 = Vector3(1, 0, 2)
<<<<<<< HEAD


func init_this_fucking_world(arena: Arena) -> void:
	self.arena = arena
	grid = Grid.new()
	environment_manager = EnvironmentManager.new()
	environment_manager.initialize_enironment()
=======

func init_this_fucking_world(arena: Arena) -> void:
	self.arena = arena
	grid = preload("res://scripts/common/grid.gd").Grid.new()
	environment_manager = preload("res://scripts/common/environment_manager.gd").EnvironmentManager.new()
	print(grid.grid)
>>>>>>> development
	find_all_entities()
	subscribe_all()

func find_all_entities() -> void:
	var children = arena.get_children()
	
	for child in children:
		if child is Entity:
			entities.append(child)

func subscribe_all() -> void:
		for entity in entities:
			entity.subscribe()
