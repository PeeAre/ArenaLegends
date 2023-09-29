extends Character
class_name Player

var move: bool = false
var deg_cos: float = 0


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
	target_position = position
	state = IdleState.new(self)

func _if_signal_tile_selected(target_position: Vector3) -> void:
	self.target_position = target_position
	direction_to_target = (body.global_position - target_position) * Vector3(1, 0, 1)
	deg_cos = body.transform.basis.z.normalized().dot(direction_to_target.normalized())
