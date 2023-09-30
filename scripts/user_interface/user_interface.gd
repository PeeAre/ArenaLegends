extends Control
class_name UserInterface

var is_moving_mode_active: bool = false
var is_shooting_mode_active: bool = false


func _ready() -> void:
	set_game_labels_position()
	set_game_labels_title()

func set_game_labels_position() -> void:
	var game_stage_label_position: Vector2 = Vector2(get_window().size.x / 2 - $GameStage.size.x / 2, get_window().size.y / 12 - $GameStage.size.y / 2)
	$GameStage.position = game_stage_label_position
	var game_mode_label_position: Vector2 = Vector2(get_window().size.x / 2 - $GameMode.size.x / 2, get_window().size.y / 8 - $GameMode.size.y / 2)
	$GameMode.position = game_mode_label_position

func set_game_labels_title() -> void:
	$GameStage.text = "Planing stage"
	$GameMode.text = "Moving mode"

func switch_mode(button_name: String) -> void:
	var game_mode_buttons = get_tree().get_nodes_in_group("game_mode_buttons")
	
	for button in game_mode_buttons:
		if button.name != button_name:
			button.disable()

func _if_signal_action_pressed(name: String):
	switch_mode(name)

func _if_signal_move_pressed(name: String):
	switch_mode(name)

func _if_signal_shoot_pressed(name: String):
	switch_mode(name)
