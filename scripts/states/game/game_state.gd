extends State
class_name GameState

var user_interface: UserInterface = null

func _init(user_interface: UserInterface) -> void:
	self.user_interface = user_interface
	user_interface.add_child(self)

func to_action() -> void:
	pass

func to_planing() -> void:
	pass
