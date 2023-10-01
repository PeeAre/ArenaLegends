extends CharacterState
class_name RunState

const ANIMATION_KEY = "run"
const ANIMATION_LOOP_MODE = Animation.LOOP_LINEAR


func _init(character: Character, old_character_state: CharacterState = null) -> void:
	character.body.velocity.x = character.body.transform.basis.z.normalized().x * 32 * Hub.arena.playerSpeed * 0.01
	character.body.velocity.z = character.body.transform.basis.z.normalized().z * 32 * Hub.arena.playerSpeed * 0.01
	super(character, ANIMATION_KEY, ANIMATION_LOOP_MODE, old_character_state)

func _physics_process(_delta) -> void:
	var is_in_target_position: bool = abs((character.body.global_position \
			* Vector3(1, 0, 1) - target_position).length()) <= 0.1
	
	if is_in_target_position:
		actions_order.pop_front()
		print("in run: ", actions_order)
		to_idle()
	
	character.body.move_and_slide()

func to_idle() -> void:
	character.body.global_position.x = target_position.x
	character.body.global_position.z = target_position.z
	character.body.velocity = Vector3.DOWN
	character.remove_child(self)
	
	if actions_order.is_empty():
		character.state = IdleState.new(character)
		Hub.game_mode = Hub.GameMode.PENDING
	else:
		character.state = IdleState.new(character, self)

func to_hit() -> void:
	pass

func to_die() -> void:
	pass
