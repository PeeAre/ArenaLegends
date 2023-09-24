extends Entity
class_name Player

const gravity: float = 10

var player: CharacterBody3D = null
var target_position: Vector3 = Vector3.ZERO
var target_vector: Vector3 = Vector3.ZERO
var current_vector: Vector3 = Vector3.ZERO


func _ready() -> void:
	expected_signals["tile_selected"] = _if_signal_move
	player = $Body
	position = Hub.palyer_spawn_position
	current_vector = transform.basis.z

func _physics_process(delta) -> void:
	var deg_cos = target_vector.normalized().dot(transform.basis.z.normalized())
	player.velocity = gravity * Vector3.DOWN
	
	if deg_cos > -0.98:
		transform.basis = Basis(Quaternion(transform.basis)
				.slerp(Quaternion(Basis.looking_at(target_vector, Vector3.UP)), 5 * delta))
	elif target_vector.length() - current_vector.length() > 0.02:
		transform.basis = Basis.looking_at(target_vector, Vector3.UP)
		position += target_vector * 0.2 * Hub.arena.playerSpeed * delta
		current_vector += target_vector * 0.2 * Hub.arena.playerSpeed * delta
	elif position != target_position:
		position = target_position
	
	player.move_and_slide()

func _if_signal_move(vec: Vector3) -> void:
	target_vector = vec - position
	target_position = vec
	current_vector = Vector3.ZERO
