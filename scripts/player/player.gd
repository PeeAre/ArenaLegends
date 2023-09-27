extends Entity
class_name Player

const gravity: float = 10

var player: CharacterBody3D = null
<<<<<<< HEAD
var animation: AnimationPlayer = null
var target_position: Vector3 = Vector3.ZERO
var target_vector: Vector3 = Vector3.ZERO
=======
var target_position: Vector3 = Vector3.ZERO
var target_vector: Vector3 = Vector3.ZERO
var looking_direction: Vector3 = Vector3.ZERO
>>>>>>> development
var move: bool = false
var deg_cos: float


func _ready() -> void:
<<<<<<< HEAD
	expected_signals["tile_selected"] = _if_signal_tile_selected
	player = $Body
	animation = $AnimationPlayer
	position = Hub.palyer_spawn_position
=======
	expected_signals["tile_selected"] = _if_signal_move
	player = $Body
	position = Hub.palyer_spawn_position
	looking_direction = basis.z
>>>>>>> development
	target_position = position
	deg_cos = player.transform.basis.z.normalized().dot(target_vector.normalized())

func _physics_process(delta) -> void:
	player.velocity = gravity * Vector3.DOWN
<<<<<<< HEAD
	
	if player.global_position == target_position:
		target_vector = Vector3.FORWARD
	else:
		target_vector = (player.global_position - target_position) * Vector3(1, 0, 1)
	
	run()
	
	if deg_cos >= -0.98:
=======
	target_vector = (target_position - player.global_position) * Vector3(1, 0, 1)
	
	if deg_cos >= -0.98:
		print("looking direction: ", looking_direction)
		print("target position", target_position)
		print("target local position", to_local(target_position))
		print("target vector", target_vector)
		print("player global position", player.global_position)
		print("node position", position)
		print("player position", player.position)
		print("deg cos: ", deg_cos)
>>>>>>> development
		player.transform.basis = Basis(Quaternion(player.transform.basis)
			.slerp(Quaternion(Basis
			.looking_at(target_vector, Vector3.UP)), 4 * delta))
		player.transform.basis.orthonormalized()
		deg_cos = player.transform.basis.z.normalized().dot(target_vector.normalized())
	elif deg_cos != -1:
		player.transform.basis = player.transform.basis.looking_at(target_vector, Vector3.UP)
		player.transform.basis.orthonormalized()
		deg_cos = -1
		move = true
	elif move:
<<<<<<< HEAD
		player.velocity.x = player.transform.basis.z.normalized().x * 32 * Hub.arena.playerSpeed * delta
		player.velocity.z = player.transform.basis.z.normalized().z * 32 * Hub.arena.playerSpeed * delta
=======
		player.velocity.x = (-player.transform.basis.z).normalized().x * 20 * Hub.arena.playerSpeed * delta
		player.velocity.z = (-player.transform.basis.z).normalized().z * 20 * Hub.arena.playerSpeed * delta
>>>>>>> development
		
		if abs((player.global_position * Vector3(1, 0, 1) - target_position).length()) <= 0.1:
			player.global_position.x = target_position.x
			player.global_position.z = target_position.z
			move = false
	else:
		player.transform.basis = Basis(Quaternion(player.transform.basis)
			.slerp(Quaternion(Basis
<<<<<<< HEAD
			.looking_at(transform.basis.x, Vector3.UP)), 4 * delta))
	
	player.move_and_slide()

func run() -> void:
	if move:
		animation.play("Running_A")
	else:
		animation.play("Idle")

func _if_signal_tile_selected(target_position: Vector3) -> void:
=======
			.looking_at(-transform.basis.x, Vector3.UP)), 4 * delta))
	
	player.move_and_slide()

func _if_signal_move(target_position: Vector3) -> void:
>>>>>>> development
	self.target_position = target_position
	target_vector = (target_position - player.global_position) * Vector3(1, 0, 1)
	deg_cos = player.transform.basis.z.normalized().dot(target_vector.normalized())
	move = false
