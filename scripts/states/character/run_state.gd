extends CharacterState
class_name RunState

func _init(character: Character) -> void:
	self.character = character
	character.add_child(self)
	animation_name = character.animation_names.get("run")
	character.animation.get_animation(animation_name).loop_mode = Animation.LOOP_LINEAR
	character.animation.play(animation_name)
	character.body.velocity.x = character.body.transform.basis.z.normalized().x * 32 * Hub.arena.playerSpeed * 0.01
	character.body.velocity.z = character.body.transform.basis.z.normalized().z * 32 * Hub.arena.playerSpeed * 0.01

func _physics_process(_delta) -> void:
	if abs((character.body.global_position * Vector3(1, 0, 1) - character.target_position).length()) <= 0.1:
		character.body.global_position.x = character.target_position.x
		character.body.global_position.z = character.target_position.z
		character.body.velocity = Vector3.ZERO
		idle()
	
	character.body.move_and_slide()

func idle() -> void:
	character.remove_child(self)
	character.state = IdleState.new(character)

func walk() -> void:
	pass

func run() -> void:
	pass

func shoot() -> void:
	pass

func die() -> void:
	pass

func hit() -> void:
	pass
