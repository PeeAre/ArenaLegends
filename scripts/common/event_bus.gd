extends Node

signal object_selected(vec: Vector3)
signal tile_selected(vec: Vector3)
signal mouse_hovered(area_id: int)
signal mouse_button_pressed(button: int)
signal device_moved(direction: Vector2i)
signal device_scrolled(action: String)
signal pause_button_pressed()
signal action_mode_enabled()
signal moving_mode_enabled()
signal shooting_mode_enabled()

func get_all_signals() -> Array[Signal]:
	var signals: Array[Signal] = []
	var property_list: Array[Dictionary] = get_script().get_script_signal_list()
	
	if !property_list.is_empty():
		for property in property_list:
			signals.append(get(property.name))
	
	return signals
