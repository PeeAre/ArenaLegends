extends CharacterState
class_name IdleState

const ANIMATION_KEY = "idle"
const ANIMATION_LOOP_MODE = Animation.LOOP_LINEAR


func _init(character: Character, target_position: Vector3 = character.position,
		direction_to_target: Vector3 = Vector3.ZERO) -> void:
	super(character, ANIMATION_KEY, ANIMATION_LOOP_MODE,
			target_position, direction_to_target)

func _physics_process(_delta):
	var is_not_looking_at_target = direction_to_target_cos >= -0.98 \
			&& direction_to_target_cos <= 0.98 \
			|| direction_to_target_cos >= 1
	var is_not_in_target_position = direction_to_target_cos >= -1 \
			&& character.body.global_position * Vector3(1, 0, 1) != target_position
	
	if is_not_looking_at_target:
		turn(_delta)
	elif is_not_in_target_position:
		to_run()

func to_run() -> void:
	character.body.transform.basis = character.body.transform.basis.looking_at(direction_to_target, Vector3.UP)
	direction_to_target_cos = character.body.transform.basis.z.normalized().dot(direction_to_target.normalized())
	character.remove_child(self)
	character.state = RunState.new(character, target_position, direction_to_target)

func to_shoot() -> void:
	pass

func to_hit() -> void:
	pass

func to_die() -> void:
	pass

func turn(delta: float) -> void:
	character.body.transform.basis = Basis(Quaternion(character.body.transform.basis)
		.slerp(Quaternion(Basis
		.looking_at(direction_to_target, Vector3.UP)), 4 * delta))
	direction_to_target_cos = character.body.transform.basis.z.normalized().dot(direction_to_target.normalized())
