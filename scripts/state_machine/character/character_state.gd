extends State
class_name CharacterState

var animation_player: AnimationPlayer = null
var animation_name: String = ""
var movement: CharacterMovement = null
var is_animation_finished: bool = false


func _init(animation_player: AnimationPlayer, movement: CharacterMovement, animation_name: String, animation_loop_mode: int) -> void:
	self.animation_player = animation_player
	self.movement = movement
	self.animation_name = animation_name
	animation_player.get_animation(animation_name).loop_mode = animation_loop_mode

func on_enter():
	animation_player.play(animation_name)
	animation_player.animation_finished.connect(_if_signal_animation_finished)

func on_exit():
	animation_player.animation_finished.disconnect(_if_signal_animation_finished)

func _if_signal_animation_finished(animation_name: String) -> void:
	is_animation_finished = true
	prints("Animation finished")
