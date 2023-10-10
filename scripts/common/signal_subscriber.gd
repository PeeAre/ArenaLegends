class_name SignalSubscriber

func subscribe(key: String, callable: Callable) -> void:
	for sig in EventBus.get_all_signals():
		if key == sig.get_name():
			sig.connect(callable)
			break
