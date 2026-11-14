extends Node3D

var camera: Camera3D 
var film: int

var velocity: Vector2
#var acceleration: Vector2

#var forward: Vector3
#var upward: Vector3
#var rightward: Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera = $Camera3D
	#forward= self.global_position + Vector3.FORWARD
	#upward= self.global_position + Vector3.UP
	#rightward =forward.cross(upward)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_move()
	_look(delta)
	
	pass


func _move():
	velocity = Input.get_vector("Walk Left","Walk Right","Walk Forward","Walk Back")
	#velocity.rotated(self.*self.rotation.y)
	self.position.x+=velocity.x
	self.position.z+=velocity.y
	velocity=Vector2()
	
	pass


func _look(delta: float):
	var rotate = Input.get_vector("Look Left","Look Right","Look Up","Look Down")
	print(rotate)
	self.rotation.y-=deg_to_rad(rotate.x)
	self.rotation.x-=deg_to_rad(rotate.y)
	rotate=Vector2()
	
	pass
