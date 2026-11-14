extends CharacterBody3D


const SPEED = 5.0
@onready var camera = $Camera3D
#const JUMP_VELOCITY = 4.5
var film: int;
const RAY_LENGTH = 1000.0

#func _unhandled_input(event) -> void:
#	if event is InputEventKey and event.pressed and event.keycode == "Take Photo":
#		print("Photo taken")
#		var from = camera.project_ray_origin(event.position)
#		var to = from + camera.project_ray_normal(event.position) * RAY_LENGTH

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("Walk Left","Walk Right","Walk Forward","Walk Back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	_look()
	
	if Input.is_action_just_pressed("Take Photo"):
		print("Photo taken")


func _look()->void:
	var rotate = Input.get_vector("Look Left","Look Right","Look Up","Look Down")
	#print(rotate)
	self.rotation.y-=deg_to_rad(rotate.x)
	camera.rotation.x-=deg_to_rad(rotate.y)#We don't need to pitch the player up and down, but the camera.
	rotate = Vector2()
	pass
