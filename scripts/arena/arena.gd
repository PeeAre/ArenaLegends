extends Node3D
class_name Arena

@export var scrollRange: Vector2 = Vector2(2, 4)
@export var gridSize: Vector2i = Vector2i(8, 8)
@export var distanceFromTarget: float = 10
@export var initialObservationTarget: NodePath = ""


func _ready() -> void:
	Hub.init_this_fucking_world(self)
