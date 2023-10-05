extends Entity
class_name Character

const gravity: float = 10
var state: CharacterState
var animation_names: Dictionary = {}
var animation: AnimationPlayer = null
var body: CharacterBody3D = null
