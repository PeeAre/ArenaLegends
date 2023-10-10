extends Entity
class_name Character

const gravity: float = 10
var animation: AnimationPlayer = null
var body: CharacterBody3D = null
var state_machine: CharacterStateMachine = null:
	set(value):
		if state_machine != null:
			remove_child(state_machine)
		
		state_machine = value
		add_child(state_machine)

func _physics_process(_delta) -> void:
	body.move_and_slide()
