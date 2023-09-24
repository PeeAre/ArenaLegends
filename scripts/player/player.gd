extends Entity
class_name Player

@export var Speed: float = 8
@export var Gravity: float = 10

var player
var vector_to_change: Vector3
var position_to_change: Vector3
var min_to_change: Vector3 = Vector3.ZERO
var rotation_y: float = 0
var direction: Vector3 = Vector3.ZERO
var motions: Dictionary = {
	"move_forward": Vector3.FORWARD,
	"move_back": Vector3.BACK,
	"move_left": Vector3.LEFT,
	"move_right": Vector3.RIGHT,
}


func _ready() -> void:
	vector_to_change = -transform.basis.z
	EventBus.tile_selected.connect(_if_signal_move)
	player = $Body
	position = Vector3(3, 0, 2)

func _physics_process(delta):
	player.velocity = Gravity * Vector3.DOWN
	
	var deg_cos = vector_to_change.normalized().dot(transform.basis.z.normalized())
	
	if deg_cos > -0.98:
		transform.basis = Basis(Quaternion(transform.basis)
				.slerp(Quaternion(Basis.looking_at(vector_to_change, Vector3.UP)), 5 * delta))
	elif vector_to_change.length() - min_to_change.length() > 0.02:
		transform.basis = Basis.looking_at(vector_to_change, Vector3.UP)
		position += vector_to_change * 0.03
		min_to_change += vector_to_change * 0.03
	
	player.move_and_slide()

func _if_signal_move(vec: Vector3) -> void:
	vector_to_change = vec - position
	position_to_change = vec
	min_to_change = Vector3.ZERO
