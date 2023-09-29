extends CharacterState
class_name IdleState

func _init(character: Character) -> void:
	self.character = character
	character.add_child(self)
	animation_name = character.animation_names.get("idle")
	character.animation.get_animation(animation_name).loop_mode = Animation.LOOP_LINEAR
	character.animation.play(animation_name)

func _physics_process(_delta):
	if character.deg_cos >= -0.98 && character.deg_cos <= 0.98 || character.deg_cos == 1:
		character.body.transform.basis = Basis(Quaternion(character.body.transform.basis)
			.slerp(Quaternion(Basis
			.looking_at(character.direction_to_target, Vector3.UP)), 4 * _delta))
		character.deg_cos = character.body.transform.basis.z.normalized().dot(character.direction_to_target.normalized())
	elif character.deg_cos != -1:
		character.body.transform.basis = character.body.transform.basis.looking_at(character.direction_to_target, Vector3.UP)
		character.deg_cos = character.body.transform.basis.z.normalized().dot(character.direction_to_target.normalized())
		run()

func walk() -> void:
	pass

func run() -> void:
	character.remove_child(self)
	character.state = RunState.new(character)

func shoot() -> void:
	pass

func die() -> void:
	pass

func hit() -> void:
	pass
