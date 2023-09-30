extends Button

var is_active = false
var theme_stylebox: StyleBox = null


func _ready() -> void:
	theme_stylebox = get_theme_stylebox("normal")
	theme_stylebox.bg_color = Color(0.4, 0.4, 0.4)
	add_theme_stylebox_override("normal", theme_stylebox)
	add_theme_stylebox_override("hover", theme_stylebox)
	add_theme_stylebox_override("pressed", theme_stylebox)
	add_theme_stylebox_override("disabled", theme_stylebox)
	add_theme_stylebox_override("focus", theme_stylebox)

func _pressed():
	if is_active:
		disable()
	else:
		theme_stylebox.bg_color = Color("4b40cb")
		size = Vector2(240, 64)
		Hub.game_mode = Hub.GameMode.MOVING
		is_active = true
	
	add_theme_stylebox_override("normal", theme_stylebox)
	add_theme_stylebox_override("hover", theme_stylebox)
	add_theme_stylebox_override("pressed", theme_stylebox)
	add_theme_stylebox_override("disabled", theme_stylebox)
	add_theme_stylebox_override("focus", theme_stylebox)

func disable() -> void:
	theme_stylebox.bg_color = Color(0.4, 0.4, 0.4)
	size = Vector2(64, 64)
	is_active = false
