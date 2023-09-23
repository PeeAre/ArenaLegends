extends CharacterBody3D
class_name Player

const Handler = preload("res://player/handler.gd")

@export var Speed: float = 8
@export var Gravity: float = 10

var handler
var rotation_y: float = 0
var direction: Vector3 = Vector3.ZERO
var motions: Dictionary = {
	"move_forward": Vector3.FORWARD,
	"move_back": Vector3.BACK,
	"move_left": Vector3.LEFT,
	"move_right": Vector3.RIGHT,
}


func _ready() -> void:
	handler = Handler.Handler.new()


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		handler.key_handle(self, event as InputEventKey)
	
	if event is InputEventMouse:
		handler.mouse_handle(self, event as InputEventMouse)


func _physics_process(delta):
	velocity = Gravity * Vector3.DOWN
	
	if direction != Vector3.ZERO:
		velocity.x = direction.normalized().x * Speed
		velocity.z = direction.normalized().z * Speed
		velocity = velocity.rotated(Vector3.UP, rotation_y)
		transform.basis = Basis(Quaternion(transform.basis)
			.slerp(Quaternion(Basis.looking_at(Vector3(velocity.x, 0, velocity.z), Vector3.UP)), 10 * delta))
	
		print(position.y)
	
	move_and_slide()
