class Subscriber:
	const STORAGE_TYPE = preload("res://scripts/common/storage.gd").Storage
	var storage
	
	func _init(storage) -> void:
		self.storage = storage
		subscribe_all(self.storage as STORAGE_TYPE)
	
	func subscribe_all(storage: STORAGE_TYPE) -> void:
		for entity in storage.entities:
			if !(entity is Entity):
				continue
			
			for sig in storage.signals:
				entity.subscribe(sig)
