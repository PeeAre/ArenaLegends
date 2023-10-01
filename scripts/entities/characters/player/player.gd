extends Character
class_name Player

func _ready() -> void:
	expected_signals["tile_selected"] = _if_signal_tile_selected
	expected_signals["action_mode_enabled"] = _if_signal_action_mode_enabled
	animation_names = {
		"idle": "Idle",
		"run": "Running_A",
		"shoot": "1H_Ranged_Shoot",
		"hit": "Hit_A",
		"die": "Death_B"
	}
	animation = $AnimationPlayer as AnimationPlayer
	body = $Body as Node3D
	position = Hub.palyer_spawn_position
	state = IdleState.new(self)

func _if_signal_tile_selected(target_position: Vector3) -> void:
	state.action_stack[Hub.game_mode] = target_position
	
	if state.action_stack.has(Hub.GameMode.SHOOTING):
		EventBus.activate_action_button.emit()

func _if_signal_action_mode_enabled() -> void:
	state.actions_order.append_array(state.action_stack.keys())
	print("in player: ", state.actions_order)
	state.target_position = state.action_stack[state.actions_order.front()]
	state.direction_to_target = (body.global_position - state.action_stack[state.actions_order.front()]) * Vector3(1, 0, 1)
	state.is_looking_at_target = body.transform.basis.z.normalized().dot(state.direction_to_target.normalized()) == -1
