extends Control
class_name Menu

var is_pause_show: bool = false


func _ready() -> void:
	$Exit.position = Vector2(get_window().size.x / 2 - $Exit.size.x / 2, get_window().size.y / 2 - $Exit.size.y / 2)
	EventBus.pause_button_pressed.connect(_if_signal_pause_button_pressed)

func _process(delta) -> void:
	if is_pause_show:
		Hub.arena.hide()
		show()
	else:
		Hub.arena.show()
		hide()

func _if_signal_pause_button_pressed() -> void:
	is_pause_show = !is_pause_show

func _if_signal_exit_pressed():
	get_tree().quit()
