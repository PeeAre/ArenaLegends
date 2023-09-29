extends State
class_name CharacterState

var character: Character = null
var animation_name: String = ""
var target_position: Vector3 = Vector3.ZERO
var direction_to_target: Vector3 = Vector3.ZERO
var direction_to_target_cos: float = 0


func _init(character: Character, animation_key: String, animation_loop_mode: int, target_position: Vector3 = character.position,
		direction_to_target: Vector3 = Vector3.ZERO) -> void:
	self.character = character
	character.add_child(self)
	animation_name = character.animation_names.get(animation_key)
	character.animation.get_animation(animation_name).loop_mode = animation_loop_mode
	character.body.velocity += Vector3.DOWN * 10
	self.target_position = target_position
	self.direction_to_target = direction_to_target
	direction_to_target_cos = character.body.transform.basis.z.normalized().dot(direction_to_target.normalized())
	character.animation.play(animation_name)

func to_idle() -> void:
	pass

func to_run() -> void:
	pass

func to_shoot() -> void:
	pass

func to_hit() -> void:
	pass

func to_die() -> void:
	pass
