extends Control
class_name UserInterface

var is_action_pressed: bool = false
var is_move_toggled: bool = false
var is_shoot_toggled: bool = false


func _ready() -> void:
	var game_stage_label_position: Vector2 = Vector2(get_window().size.x / 2 - $GameStage.size.x / 2, get_window().size.y / 12 - $GameStage.size.y / 2)
	$GameStage.position = game_stage_label_position
