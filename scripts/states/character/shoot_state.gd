extends CharacterState
class_name ShootState

const ANIMATION_KEY = "shoot"
const ANIMATION_LOOP_MODE = Animation.LOOP_NONE


func _init(character: Character, old_character_state: CharacterState = null) -> void:
	character.animation.animation_finished.connect(_if_signal_shooting_finished)
	super(character, ANIMATION_KEY, ANIMATION_LOOP_MODE, old_character_state)

func to_idle() -> void:
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

func _if_signal_shooting_finished(animation_name: String) -> void:
	actions_order.pop_front()
	to_idle()
