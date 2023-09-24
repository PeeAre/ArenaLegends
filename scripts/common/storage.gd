class Storage:
	var arena: Arena = null
	var entities: Array[Node3D] = []
	var signals: Array[Signal] = []
	
	
	func _init(entities: Array[Node3D]) -> void:
		self.entities = entities
		find_arena()
		find_all_signals()
	
	func find_all_signals() -> void:
		for node in self.entities:
			if node is Entity:
				var property_list: Array[Dictionary] = node.get_script().get_script_signal_list()
				
				if !property_list.is_empty():
					for property in property_list:
						if unique_signals(signals, node.get(property.name)):
							signals.append(node.get(property.name))
	
	func find_arena() -> void:
		for node in self.entities:
			if node is Arena:
				arena = node
				return
	
	func unique_signals(signals: Array, sig: Signal) -> bool:
		for s in signals:
			if s.get_name() == sig.get_name():
				return false
		
		return true
