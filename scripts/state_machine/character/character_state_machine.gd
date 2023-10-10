extends Node
class_name CharacterStateMachine

const IDLE_KEY = "idle"
const RUN_KEY = "run"
const SHOOT_KEY = "shoot"

var private_state_machine: StateMachine = StateMachine.new()

var input = CharacterInput.new()

var private_idle_state: IdleState
var private_run_state: RunState
var private_shoot_state: ShootState

func _init(animation_names: Dictionary, movement: CharacterMovement, animation_player: AnimationPlayer):
	private_idle_state = IdleState.new(animation_player, movement, animation_names[IDLE_KEY])
	private_run_state = RunState.new(animation_player, movement, animation_names[RUN_KEY])
	private_shoot_state = ShootState.new(animation_player, movement, animation_names[SHOOT_KEY])

func _ready():
	
	var idle_to_run = Transition.new(private_idle_state, private_run_state, func(): return input.velocity * Vector3(1, 0, 1) != Vector3.ZERO)
	private_state_machine.add_transition(idle_to_run)
	
	var run_to_idle = Transition.new(private_run_state, private_idle_state, func(): return input.velocity * Vector3(1, 0, 1) == Vector3.ZERO)
	private_state_machine.add_transition(run_to_idle)
	
	var idle_to_shoot = Transition.new(private_idle_state, private_shoot_state, func(): return input.is_shooting)
	private_state_machine.add_transition(idle_to_shoot)
	
	var shoot_to_idle = Transition.new(private_shoot_state, private_idle_state, func(): return private_shoot_state.is_animation_finished)#Todo predicate
	private_state_machine.add_transition(shoot_to_idle)

func _process(delta):
	private_state_machine.tick()
