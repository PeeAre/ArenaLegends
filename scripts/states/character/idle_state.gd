extends CharacterState
class_name IdleState

const ANIMATION_KEY = "idle"
const ANIMATION_LOOP_MODE = Animation.LOOP_LINEAR


func _init(character: Character, old_character_state: CharacterState = null) -> void:
	super(character, ANIMATION_KEY, ANIMATION_LOOP_MODE, old_character_state)

func _physics_process(_delta):
	if character.is_multiplayer_authority():
		var is_not_in_target_position = character.body.global_position * Vector3(1, 0, 1) != target_position
		
		if not is_looking_at_target:
			turn(_delta)
		elif Hub.game_mode == Hub.GameMode.ACTION:
			if actions_order.front() == Hub.GameMode.MOVING:
				to_run()
			else:
				to_shoot()
		
		character.rpc("remote_set_basis", character.body.transform.basis)

func to_run() -> void:
	character.remove_child(self)
	character.state = RunState.new(character, self)

func to_shoot() -> void:
	character.remove_child(self)
	character.state = ShootState.new(character, self)

func to_hit() -> void:
	pass

func to_die() -> void:
	pass

func turn(delta: float) -> void:
	character.body.transform.basis = lerp(character.body.transform.basis, character.body.transform.basis.looking_at(direction_to_target), delta * 8)
	is_looking_at_target = character.body.transform.basis.z.normalized().dot(direction_to_target.normalized()) == -1
