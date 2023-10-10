extends CharacterState
class_name ShootState

const ANIMATION_LOOP_MODE = Animation.LOOP_NONE

func _init(animation_player: AnimationPlayer, movement: CharacterMovement, animation_name: String) -> void:
	super(animation_player, movement, animation_name, ANIMATION_LOOP_MODE)
