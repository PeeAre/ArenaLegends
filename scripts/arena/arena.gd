extends Node3D
class_name Arena

@export var scrollRange: Vector2 = Vector2(2, 4)
@export var gridSize: Vector2i = Vector2i(8, 8)
<<<<<<< HEAD
@export var distanceFromTarget: float = 16
=======
@export var distanceFromTarget: float = 10
>>>>>>> development
@export var playerSpeed: float = 8


func _ready() -> void:
	Hub.init_this_fucking_world(self)
