class_name CharacterMovement

var body: CharacterBody3D = null
var direction_to_target: Vector3 = Vector3.ZERO
var target_position: Vector3 = Vector3.ZERO:
	set(value):
		target_position = value
		direction_to_target = (body.global_position - value) * Vector3(1, 0, 1)

func _init(body: CharacterBody3D):
	self.body = body

func stop():
	body.velocity = body.velocity * Vector3.UP

func move():
	body.velocity.x = body.transform.basis.z.normalized().x * 32 * Hub.arena.playerSpeed * 0.01
	body.velocity.z = body.transform.basis.z.normalized().z * 32 * Hub.arena.playerSpeed * 0.01

func turn(delta) -> bool:
	body.transform.basis = lerp(body.transform.basis, body.transform.basis.looking_at(direction_to_target), delta * 8)
	return body.transform.basis.z.normalized().dot(direction_to_target.normalized()) == -1
