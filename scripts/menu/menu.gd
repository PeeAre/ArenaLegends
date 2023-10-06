extends Control
class_name Menu

var is_pause_mode: bool = true


func _ready() -> void:
	var start_position: Vector2 = Vector2(get_window().size.x / 2 - $Exit.size.x / 2, get_window().size.y / 4 - $Exit.size.y / 2)
	var exit_position: Vector2 = Vector2(get_window().size.x / 2 - $Exit.size.x / 2, get_window().size.y / 2 - $Exit.size.y / 2 + 16)
	$Start.position = start_position
	$Exit.position = exit_position
	EventBus.pause_button_pressed.connect(_if_signal_pause_button_pressed)

func _process(delta) -> void:
	if is_pause_mode:
		Hub.arena.hide()
		Hub.user_interface.hide()
		show()
	else:
		Hub.arena.show()
		Hub.user_interface.show()
		hide()

func _if_signal_pause_button_pressed() -> void:
	is_pause_mode = !is_pause_mode

func _if_signal_start_pressed():
	var networking_node = preload("res://scenes/networking.tscn").instantiate()
	get_parent().add_child(networking_node)
	is_pause_mode = false

func _if_signal_exit_pressed():
	get_tree().quit()


func _if_signal_host_toggled(button_pressed):
	Hub.is_server = not Hub.is_server
