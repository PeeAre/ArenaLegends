extends Node3D
class_name Arena

@export var GridSize: Vector2i = Vector2i.ZERO

var observer = preload("res://scripts/common/observer.gd").Observer


func _ready() -> void:
	observer.new(self)
