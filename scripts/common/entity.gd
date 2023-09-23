extends Node3D
class_name Entity

var expected_signals: Dictionary = {}

func subscribe(target_signal: Signal) -> void:
	if !expected_signals.is_empty():
		var signal_name = target_signal.get_name()
		
		for key in expected_signals:
			if key == signal_name:
				target_signal.connect(expected_signals[key])
				break
