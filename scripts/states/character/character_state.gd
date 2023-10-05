extends State
class_name CharacterState

var action_stack: Dictionary = {}
var actions_order: Array[Hub.GameMode] = []
var character: Character = null
var animation_name: String = ""
var target_position: Vector3 = Vector3.ZERO
var direction_to_target: Vector3 = Vector3.RIGHT
var is_looking_at_target: bool = false


func _init(character: Character, animation_key: String, animation_loop_mode: int, \
		old_character_state: CharacterState = null) -> void:
	self.character = character
	character.add_child(self)
	animation_name = character.animation_names.get(animation_key)
	character.animation.get_animation(animation_name).loop_mode = animation_loop_mode
	character.body.velocity += Vector3.DOWN * 10
	
	if old_character_state != null:
		action_stack = old_character_state.action_stack
		actions_order = old_character_state.actions_order
		target_position = action_stack.get(actions_order.front())
		direction_to_target = (character.body.global_position - action_stack[actions_order.front()]) * Vector3(1, 0, 1)
		is_looking_at_target = character.body.transform.basis.z.normalized().dot(direction_to_target.normalized()) == -1
	
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
