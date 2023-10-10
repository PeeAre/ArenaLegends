class_name StateMachine

var private_any_state_transition: Array[Transition] = Array()
var private_state_to_transition: Dictionary = {}

var current_state: State = null
var private_current_transitions: Array[Transition]

func add_transition(new_transition: Transition):
	if new_transition.from == null:
		private_any_state_transition.append(new_transition)
		return
	if !private_state_to_transition.has(new_transition.from):
		private_state_to_transition.merge({new_transition.from: Array()})
	(private_state_to_transition[new_transition.from] as Array[Transition]).append(new_transition)

func set_state(state: State):
	current_state = state
	
	current_state.on_enter()
	private_current_transitions = Array(private_any_state_transition)
	
	if !private_state_to_transition.has(current_state): return
	
	private_current_transitions.append_array(private_state_to_transition[current_state])

func tick():
	if current_state == null: return
	
	var satisfied_transitions = private_current_transitions.filter(func(transition: Transition): transition.predicate)
	
	if satisfied_transitions.is_empty():
		current_state.on_tick()
		return
	
	if satisfied_transitions.size() > 1:
		printerr("More than one transition satisfies")
		return
	
	change_state(satisfied_transitions[0])

func change_state(transition: Transition):
	current_state.on_exit()
	set_state(transition.to)
