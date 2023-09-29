extends Character
class_name Player

func _ready() -> void:
	expected_signals["tile_selected"] = _if_signal_tile_selected
	animation_names = {
		"idle": "Idle",
		"run": "Running_A",
		"shoot": "1H_Ranged_Shoot",
		"hit": "Hit_A",
		"die": "Death_B"
	}
	animation = $AnimationPlayer
	body = $Body
	position = Hub.palyer_spawn_position
	state = IdleState.new(self)

func _if_signal_tile_selected(target_position: Vector3) -> void:
	state.target_position = target_position
	state.direction_to_target = (body.global_position - target_position) * Vector3(1, 0, 1)
	state.direction_to_target_cos = body.transform.basis.z.normalized().dot(state.direction_to_target.normalized())
