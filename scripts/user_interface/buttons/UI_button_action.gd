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

func _on_pressed():
	is_active = not is_active
	
	if is_active:
		theme_stylebox.bg_color = Color("4b40cb")
	else:
		theme_stylebox.bg_color = Color(0.4, 0.4, 0.4)
	
	add_theme_stylebox_override("normal", theme_stylebox)
	add_theme_stylebox_override("hover", theme_stylebox)
	add_theme_stylebox_override("pressed", theme_stylebox)
	add_theme_stylebox_override("disabled", theme_stylebox)
	add_theme_stylebox_override("focus", theme_stylebox)
