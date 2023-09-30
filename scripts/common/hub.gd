extends Node

var environment_manager: EnvironmentManager = null
var entities: Array[Entity] = []
var grid: Grid = null
var arena: Arena = null
var user_interface: UserInterface = null
var menu: Menu = null
var camera: Camera = null
var player: Player = null
var tile_size: Vector3 = Vector3.ZERO
var palyer_spawn_position: Vector3 = Vector3(1, 0, 2)

func init_this_fucking_world(main: Main) -> void:
	self.menu = main.get_node("Menu")
	self.arena = main.get_node("Arena")
	self.user_interface = main.get_node("UserInterface")
	grid = Grid.new()
	environment_manager = EnvironmentManager.new()
	environment_manager.initialize_enironment()
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
