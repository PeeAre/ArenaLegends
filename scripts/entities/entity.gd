extends Node3D
class_name Entity

var expected_signals: Dictionary = {}


func subscribe() -> void:
	if !expected_signals.is_empty():
		for sig in EventBus.get_all_signals():
			for key in expected_signals:
				if key == sig.get_name():
					sig.connect(expected_signals[key])
					break
