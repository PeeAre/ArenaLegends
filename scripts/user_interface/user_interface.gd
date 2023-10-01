extends Control
class_name UserInterface

const modes: Dictionary = {
	"Move": Hub.GameMode.MOVING,
	"Shoot": Hub.GameMode.SHOOTING,
	"Action": Hub.GameMode.ACTION
}

var is_moving_mode_active: bool = false
var is_shooting_mode_active: bool = false


func _ready() -> void:
	var game_mode_label_position: Vector2 = Vector2(get_window().size.x / 2 - $GameMode.size.x / 2, get_window().size.y / 12 - $GameMode.size.y / 2)
	$GameMode.position = game_mode_label_position
	EventBus.action_mode_enabled.connect(_if_signal_action_mode_enabled)
	EventBus.pending_mode_enabled.connect(_if_signal_pending_mode_enabled)
	set_game_mode_label_title()

func _process(_delta):
	set_game_mode_label_title()

func set_game_mode_label_title() -> void:
	match Hub.game_mode:
		Hub.GameMode.PENDING:
			$GameMode.text = "Pending mode"
		Hub.GameMode.MOVING:
			$GameMode.text = "Moving mode"
		Hub.GameMode.SHOOTING:
			$GameMode.text = "Shooting mode"
		Hub.GameMode.ACTION:
			$GameMode.text = "Action mode"

func disable_buttons() -> void:
	var game_mode_buttons = get_tree().get_nodes_in_group("game_mode_buttons")
	
	for button in game_mode_buttons:
		button.disable()

func switch_mode(button_name: String) -> void:
	if get_node(button_name).is_active:
		var game_mode_buttons = get_tree().get_nodes_in_group("game_mode_buttons")
		
		for button in game_mode_buttons:
			if button.name != button_name:
				button.disable()
			else:
				Hub.game_mode = modes[button_name]
	else:
		Hub.game_mode = Hub.GameMode.PENDING

func _if_signal_action_pressed(name: String):
	switch_mode(name)

func _if_signal_move_pressed(name: String):
	switch_mode(name)

func _if_signal_shoot_pressed(name: String):
	switch_mode(name)

func _if_signal_action_mode_enabled() -> void:
	$Action.disabled = true
	$Move.disabled = true
	$Shoot.disabled = true

func _if_signal_pending_mode_enabled() -> void:
	$Move.disabled = false
	$Shoot.disabled = false
	disable_buttons()
