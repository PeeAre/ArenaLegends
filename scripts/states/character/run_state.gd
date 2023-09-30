extends CharacterState
class_name RunState

const ANIMATION_KEY = "run"
const ANIMATION_LOOP_MODE = Animation.LOOP_LINEAR


func _init(character: Character, target_position: Vector3 = character.position,
		direction_to_target: Vector3 = Vector3.ZERO) -> void:
	character.body.velocity.x = character.body.transform.basis.z.normalized().x * 32 * Hub.arena.playerSpeed * 0.01
	character.body.velocity.z = character.body.transform.basis.z.normalized().z * 32 * Hub.arena.playerSpeed * 0.01
	super(character, ANIMATION_KEY, ANIMATION_LOOP_MODE,
			target_position, direction_to_target)

func _physics_process(_delta) -> void:
	var is_in_target_position: bool = abs((character.body.global_position \
			* Vector3(1, 0, 1) - target_position).length()) <= 0.1
	
	if is_in_target_position:
		to_idle()
	
	character.body.move_and_slide()

func to_idle() -> void:
	character.body.global_position.x = target_position.x
	character.body.global_position.z = target_position.z
	character.body.velocity = Vector3.DOWN
	character.remove_child(self)
	character.state = IdleState.new(character, target_position, direction_to_target)

func to_shoot() -> void:
	pass

func to_hit() -> void:
	pass

func to_die() -> void:
	pass
