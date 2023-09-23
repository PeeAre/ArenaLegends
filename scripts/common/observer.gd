class Observer:
	var storage = preload("res://scripts/common/storage.gd").Storage
	var subscriber = preload("res://scripts/common/subscriber.gd").Subscriber
	var environment_generator = preload("res://scripts/environment/environment_generator.gd").EnvironmentGenerator
	var arena: Arena = null
	
	
	func _init(arena: Arena) -> void:
		self.arena = arena
		environment_generator = environment_generator.new(arena)
		storage = storage.new(get_all_nodes())
		subscriber = subscriber.new(storage)
	
	func get_all_nodes() -> Array[Node3D]:
		var nodes: Array[Node3D] = []
		var children = arena.get_children()
		
		for child in children:
			nodes.append(child)
		
		return nodes
