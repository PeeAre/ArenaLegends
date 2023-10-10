class_name CharacterInput

class Action:
	enum Type {MOVING, SHOOTING}
	
	var target_position: Vector3
	var type: Type
	
	func _init(target_position: Vector3, type: Type):
		self.target_position = target_position
		self.type = type

var selected_game_mode: Hub.GameMode

var signal_subscriber = SignalSubscriber.new()

var actions_order: Array[Action] = []

func _init():
	signal_subscriber.subscribe("tile_selected", _if_signal_tile_selected)
	signal_subscriber.subscribe("game_mode_changed", _if_signal_game_mode_changed)

func _if_signal_tile_selected(target_position: Vector3) -> void:
	action_stack[Hub.game_mode] = target_position
	
	if action_stack.has(Hub.GameMode.SHOOTING):
		EventBus.activate_action_button.emit()

func _if_signal_game_mode_changed(game_mode: Hub.GameMode) -> void:
	selected_game_mode = game_mode
	if game_mode == Hub.GameMode.ACTION:
		actions_order.append_array(action_stack.keys())
		print("in player: ", actions_order)
		target_position = action_stack[actions_order.front()]
		#direction_to_target = (body.global_position - action_stack[state.actions_order.front()]) * Vector3(1, 0, 1)
		#is_looking_at_target = body.transform.basis.z.normalized().dot(state.direction_to_target.normalized()) == -1
